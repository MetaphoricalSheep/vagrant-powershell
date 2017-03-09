[Array] $List = @()

Class VagrantInstance
{
    [Int] $Id
    [String] $VagrantId
    [String] $Name
    [String] $State
    [String] $Path

    VagrantInstance() { }

    VagrantInstance([Int] $id, [String] $raw)
    {
        $o = ($raw.Trim() -replace "\s+",",").Split(',')
        $this.Id = $id
        $this.VagrantId = $o[0]
        $this.Name = $o[1]
        $this.State = $o[3]
        $this.Path = Split-Path $o[4] -Leaf
    }
}

Class MenuOptions
{
    [Int] $Id
    [String] $Label

    MenuOptions() { }

    MenuOptions([Int] $id, [String] $label)
    {
        $this.Id = $id
        $this.Label = $label
    }
}

function Main() 
{
    Clear-Host
    $List = GetVagrantInstances
    Menu
}

function Menu()
{
    [Array] $menu = @()
    $menu += New-Object MenuOptions(1, "List Vagrant Status")
    $menu += New-Object MenuOptions(2, "Toggle Vagrant Instance - :id")
    $menu += New-Object MenuOptions(3, "Up Vagrant Instance - :id")
    $menu += New-Object MenuOptions(4, "Halt Vagrant Instance - :id")
    $menu += New-Object MenuOptions(5, "Halt All")
    $menu += New-Object MenuOptions(6, "Exit")
        
    OutputTable($menu)
    
    do 
    {
        $response = Read-Host "Please choose an option"
        $response = $response.ToLower().Trim().Split(" ")
        $menuItem = $response[0]
        $id = $response[1]

        if (!$id)
        {
            $id = 0
        }
    } 
    until ($("1", "2", "3", "4", "5", "6").Contains($menuItem))

    switch ($response) {
        1 { 
            Clear-Host
            OutputTable($List)
            Menu
        }
        2 {
            Toggle($id)
        }
        3 {
            Up($id)
        }
        4 {
            Down($id)
        }
        5 {
            HaltAll
        }
        6 {
            return
        }
    }
}

function Up($id)
{
    vagrant up $id
}

function Down($id)
{
    vagrant halt $id
}

function Toggle($id)
{
    $status = $List[$id].Status
    $vagrantId = $List[$id].VagrantId

    if ($status = "poweroff") 
    {
        Up($vagrantId)
    }
    else 
    {
        Down($vagrantId)
    }
}

function HaltAll()
{
    ForEach ($v in $List)
    {
        Down($v.VagrantId)
    }
}

function OutputTable([Array] $tbl)
{
    Write-Output $tbl | Format-Table -AutoSize
}

function GetVagrantInstances()
{
    [Array] $List = @()
    $vagrants = vagrant global-status | select-string -Pattern "default" -SimpleMatch
    $count = 0

    ForEach ($v in $vagrants) 
    {
        $List += New-Object VagrantInstance($count, $v.ToString())
        $count++
    }

    return $List
}

Main