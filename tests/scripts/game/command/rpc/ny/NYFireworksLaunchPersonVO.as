package game.command.rpc.ny
{
   import game.command.rpc.clan.value.ClanIconValueObject;
   
   public class NYFireworksLaunchPersonVO
   {
       
      
      private var data:Object;
      
      private var _nickname:String;
      
      private var _clanTitle:String;
      
      private var _clanIcon:ClanIconValueObject;
      
      private var _clanId:int;
      
      public function NYFireworksLaunchPersonVO(param1:Object)
      {
         super();
         this.data = param1;
         _nickname = param1.nickname;
         _clanTitle = param1.clanTitle;
         if(param1.clanIcon)
         {
            _clanIcon = ClanIconValueObject.fromRawData(param1.clanIcon);
         }
         _clanId = param1.clanId;
      }
      
      public function get nickname() : String
      {
         return _nickname;
      }
      
      public function get clanTitle() : String
      {
         return _clanTitle;
      }
      
      public function get clanIcon() : ClanIconValueObject
      {
         return _clanIcon;
      }
      
      public function get clanId() : int
      {
         return _clanId;
      }
   }
}
