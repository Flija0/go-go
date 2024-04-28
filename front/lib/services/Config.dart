class Config {
  static const apiUrl = "10.0.2.2:3000";
  static const String loginUrl = "/user/authenticate";
  static const String profileUrl = "/user/authenticate";
  static const String confirmMail = "/user/confirm/";

  static const String addDemand = "/demand/add/";
  static const String changeDemandStatus = "/demand/changeStatus/";
  static const String getSelectedDemand = "/demand/getSelectedDemand/";
  static const String getAllDemandsForTheRideCreator = "/demand/getAllDemandsForTheRideCreator/";

  static const String addCar = "/addCar";
  static const String getCar = "/getCar";


  static const String addMessage = "/message/add/";
  static const String getAllMessagesForThatConversation = "/message/get/";



  static const String addConversation = "/conversation/add/";
  static const String getAllConversationsForTheAuthentifiedUser = "/conversation/getAllConversationsForTheAuthentifiedUser/";
  static const String getSelectedConversation = "/conversation/getSelectedConversation";



  static const String addRide = "/ride/add/";//{userid}
  static const String getRide = "/ride/get/";//{id}
  static const String updateRide = "/ride/update/";
  static const String deleteRide = "/ride/delete";//{id}
  static const String getAllRidesForTodayAndTomorrow = "/ride/getAllRidesForTodayAndTomorrow";//{id}


}