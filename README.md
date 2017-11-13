# Design-Patterns-App

This app was a project for Software Architecture Design were we had to implmement a Timer/ToDo app with as much Design Patterns as possible. I was able to inculde the following:

## 1. MVC
By default an iOS app follows the Model View Controller pattern. You have your controllers, models and UI files for the views. 
I made no difference, I have my controllers in folder ```/controller```, my models in ```/model```and my views in ```/views```and also in ```main.storyboard``` where all the UI is mostly designed.
Basically each ViewController has an associated view and uses some models.

## 2. Singleton
In my app I have the class ```ItemManager.swift``` which as the name says manages all items of the app. I used Singleton pattern for this class by only having one instance in all the flow.
You can also called this static class and access it's unique instance from anywhere.

## 3. Mediator
I applied Mediator pattern also with the class ```ItemManager.swift```, it handles all comunication between the controllers and the Item models. Each item is different and can trigger different operations,
so the ItemManager is the intermediary decoupling and getting rid of links between the model itself and controllers.

## 4. Factory
In the class ```ItemFactory.swift``` the Factory pattern is implemented. Is hides the logic of creating an item from the caller class. Just receive some info to consider in the creation and then returns a newly Item object

## 5. Iterator
Even though the Iterator Pattern is widely use in Java, iOS has it's own iterator implementation for TableViews with the DataSource.
Implementing ```UITableViewDataSource```
you must provide an item for an specific index, thr dataSouce deals with matching each object with its cell creating a tableView (list) as result.
From Apple Documentation:
> UITableView declares a category on NSIndexPath that enables you to get the represented row index (row property) and section index (section property), and to construct an index path from a given row index and section index (init(row:section:) class method). (The first index in each index path identifies the section and the next identifies the row.)

## 6. Observer
This pattern requires that when one object is modified, its depenedent objects are to be notified automatically. 
I didn't made a relation between object and dependets to notify, however ```ToDoListController``` declares an observer to an specific notification which is triggered everytime an Item changes.
So when an Item changes a notification gets broadcasted and the observer (in this case ```ToDoListController```) executes specific code to refresh the Table and keep consistency via the ```ItemManager```.
The controller became an observer in this statement:
``` NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "UpdateTable"), object: nil, queue: nil, using: updateTable)```

# 7. Strategy
I follow the Strategy pattern in file ```Strategy.swift```here an interface called ```Strategy```is created and that interface has a methid called ```doOperation()```.
Two classes conform to this interface: ```OperationRestore```and ```OperationComplete```and both implement the ```doOperation()```method differently.
So at runtime it is decided which operation should run on an item depending on it's status.
Specifically in ```ItemTableViewCell.swift```:
```
if let item = item {
    if item.status == .incompleted {
        strategy = OperationComplete()
    } else {
        strategy = OperationRestore()
    }
    strategy?.doOperation(on: item)
}
```

## 8. Memento
Integrating the Memento pattern was challenging, Memento pattern is used to restore state of an object to a previous state.
I though it would be a good idea to implement it for a draft of an item. Every time an Item is being created but not saved, a new Memento object is saved with the information already given.
This can be found in the class ```Memento.swift```and one if it's uses is in ```AddTaskViewController.swift```:
```
override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !savedItem {
            if let memento = memento,
                let priority = Priority(rawValue: priorities[priorityPicker.selectedRow(inComponent: 0)]) {
                memento.saveStateToMemento(name: nameTextField.text,
                                           hours: hoursTextField.text,
                                           minutes: minutesTextField.text,
                                           seconds: secondsTextField.text,
                                           priority: priority)
            }
        }
    }
```

## 9. Facade
Facade pattern hides the complexities of the system and provides an interface to the client using which the client can access the system.
I decided to use this pattern hidding the functionality of storing the items locally to keep them even if the app is killed and then launch again.
I created a interface called ```Stored```which has a method ```store()```that will be called by another class without caring the implementation details.
The class that conforms this interface is ```ItermManager.swift``` here the ```store()```method is implemented writing the items in ```UserDefaults```.
Then in the ```AppDelegate``` on the method which is called just when the app is about to enter background this method from the manager is called:
```
func applicationDidEnterBackground(_ application: UIApplication) {
        ItemManager.getInstance().store()
    }
```

## 10. State
Lastly, in State pattern a class behavior changes based on its state. ```UITableView``` class provided by Apple has this pattern by default.
It has two states:
- normal.
- onEditing.

On each state the table has a different behavior and UI events trigger different methods. So by using UITableView I had this pattern.
