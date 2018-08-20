package game.data.storage.quest
{
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicDescription;
   
   public class QuestConditionFunction
   {
      
      public static const DAY_TIME_HOUR:String = "dayTimeHour";
      
      public static const SOCIAL_GIFT_SEND:String = "socialGiftsSent";
       
      
      private var _ident:String;
      
      private var _argNames:Array;
      
      private var _iconAssetTexture:String;
      
      private var _mechanic:MechanicDescription;
      
      private var _mechanicHelper:String;
      
      public function QuestConditionFunction(param1:Object)
      {
         super();
         _ident = param1.ident;
         _argNames = param1.argNames;
         _mechanic = DataStorage.mechanic.getByType(param1.mechanic);
         _mechanicHelper = param1.mechanicHelper;
         _iconAssetTexture = param1.iconAssetTexture;
      }
      
      public function get ident() : String
      {
         return _ident;
      }
      
      public function get argNames() : Array
      {
         return _argNames;
      }
      
      public function get iconAssetTexture() : String
      {
         return _iconAssetTexture;
      }
      
      public function get mechanic() : MechanicDescription
      {
         return _mechanic;
      }
      
      public function get mechanicHelper() : String
      {
         return _mechanicHelper;
      }
   }
}
