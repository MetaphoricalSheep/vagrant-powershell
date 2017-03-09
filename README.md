# vagrant-powershell
A powershell script to help manage vagrant instances

## Usage

1. Run the powershell script either manually or by launching the vagrant.cmd file
2. This will display the start screen:

![start-screen](https://github.com/MetaphoricalSheep/vagrant-powershell/blob/master/docs/images/start-screen.png)

  * Option 1: Display the status of all boxes that vagrant is currently aware of.
  
  ![start-screen](https://github.com/MetaphoricalSheep/vagrant-powershell/blob/master/docs/images/list-status.png)
  
  * Option 2: Toggle the status of a vagrant box between ```vagrant halt``` and ```vagrant up```. You should specify the numeric id after a space. It will default to id 0. Example ```Please choose an option: 2 1``` 1 being the id of the box to toggle.
  * Option 3: Run ```vagrant up [vagrant id]```. The id of the box should be specified after a space.
  * Option 4: Run ```vagrant halt [vagrant id]```. The id of the box should be specified after a space.
  * Option 5: Loop through all boxes and run ```vagrant halt [current vagrant id]``` on them
  * Option 6: Close the script
  
