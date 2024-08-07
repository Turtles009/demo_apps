abstract class EmployeeEvent {
  const EmployeeEvent();
}

// Event class to trigger an action of fetching employee data from API
class FetchEmployeeEvent extends EmployeeEvent {
  const FetchEmployeeEvent();
}
