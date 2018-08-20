package game.model.user
{
   import game.command.rpc.clan.value.ClanIconValueObject;
   
   public class ClanUserInfoValueObject
   {
       
      
      protected var _id:int;
      
      protected var _title:String;
      
      protected var _icon:ClanIconValueObject;
      
      public function ClanUserInfoValueObject()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function get icon() : ClanIconValueObject
      {
         return _icon;
      }
      
      protected function setup(param1:Object) : void
      {
         _id = param1.id;
         _title = param1.title;
         if(param1.icon)
         {
            _icon = ClanIconValueObject.fromRawData(param1.icon);
         }
      }
      
      function setupFromUser(param1:Object) : void
      {
         _id = param1.clanId;
         _title = param1.clanTitle;
         if(param1.clanIcon)
         {
            _icon = ClanIconValueObject.fromRawData(param1.clanIcon);
         }
         else
         {
            _icon = ClanIconValueObject.iconNull();
         }
      }
      
      public function setupFromArguments(param1:int, param2:String, param3:ClanIconValueObject) : void
      {
         _id = param1;
         _title = param2;
         _icon = param3;
      }
   }
}
