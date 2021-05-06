# FleetManagementSystem-ST
**Salesforce Fleet Management Application**

Fleet Management system is a Salesforce Lightning Application which is built on Salesforce platform allowing multiple features including:
- Users with Application access can view and perform operations
- Users with access can be able to Create/Edit/Delete the Bus records
- Users with access can be able to Create/Edit/Delete the Maintenance records
- Users with access can be able to Create/Edit/Delete the Garage records
- The Resale Value of the bus is calculated automatically based on certain conditions:
  - If Current Status of the bus is ‘Ready for use’
  - If Max Capacity of the bus is 24, the starting price = $120,000
  - If Max Capacity of the bus is 36, the starting price = $160,000
  - If the bus has AC, the Resale Value will be increased by 3% of starting price
  - If the Year of the bus is older than 1972, the Resale Value will be increased by 34% of starting price
  - If the Odometer Reading is more 100,000 miles, then the Resale Value should be decreased by $0.1 for every mile from the starting price
- Automatically creating Maintenance requests for every 5000 miles on the Buses using below conditions:
  - If Max Capacity of the bus is 60
  - Create Maintenance requests on the bus with Status = 'Open' & Current Status on Bus to 'Scheduled for maintenance' (using Last Ping Location) to find the nearest Garages using DISTANCE() & Apex Location class
  - Scheduled to automatically run every day at 9:00PM 
  - If the Maintenance Status is updated to 'In Progress', the Current Status on the Bus will be updated to 'Undergoing Repairs' automatically
  - If the Maintnenance Status is updated to 'Completed', the Current Status on the Bus will be updated to 'Ready for use' automatically

**Assumptions:**
- Only one Open Maintenance record will be present on the Bus at a given time.

**Technical Aspects:**
- Apex, Aura, JS, CSS

**Future Enhancements**
- For creating Maintenance requests for the Bus to send to a nearest Garage, check if the Garage can handle any new requests or not and then assign the Maintenance request to the garage.
- Calculate total number of Maintenance Requests roll-up fields on Bus based on the type of the schedule, that way these fields can be used in other calculations for Bus Resale Value as well.
- Creating Email Alerts to send to Bus Owner if the next Maintenance is coming soon.
- Use standard Case object for Maintenance requests as we can leverage standard functionality
- Use Account object and create relationship with Bus and Garage to better categorize the data modal
- For creating Maintenance requests for the Bus to send to only a company garage or any garage based on Bus specified basis.
- Creating multiple Maintenance requests automatically for each Bus based on criteria

**Installing FMS using an unmanaged package**

This is recommended option for any one who want to experience the app.

  1. [Sign up](https://developer.salesforce.com/signup) for a developer edition
  2. Enable My Domain. Follow the instructions to enable My Domain [here](https://trailhead.salesforce.com/en/content/learn/modules/identity_login/identity_login_my_domain).
  3. Click [this link](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t1R000001IGZK) to install the FMS unmanaged package into your developer edition org.
  4. Select Install for All Users.
  5. Assign Fleet Management System permission set & Fleet Management System Admin permission set for the users and admin accordingly.
  6. System admin can schedule **BusMaintanenceBatchJob** Batch Apex class to run everyday at 10pm from Anonymous window using command: System.schedule('MaintenanceCreationJob1', '0 0 22 * * ? *' , new BusMaintanenceBatchJob());
  7. Select Fleet Management System in the App Launcher.
  8. Experience the lightning app.
