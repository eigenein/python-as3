package game.command.rpc.player.server
{
   import game.model.user.UserInfo;
   
   public class ServerListUserValueObject extends UserInfo
   {
       
      
      private var _giveStarMoneyToOthers:int;
      
      private var _getStarMoneyFromOthers:int;
      
      private var _vipPoints:int;
      
      private var _countHeroes:int;
      
      private var _power:int;
      
      private var _currentServerId:int;
      
      public function ServerListUserValueObject(param1:Object)
      {
         super();
         parse(param1);
      }
      
      public function get giveStarMoneyToOthers() : int
      {
         return _giveStarMoneyToOthers;
      }
      
      public function set giveStarMoneyToOthers(param1:int) : void
      {
         _giveStarMoneyToOthers = param1;
      }
      
      public function get getStarMoneyFromOthers() : int
      {
         return _getStarMoneyFromOthers;
      }
      
      public function set getStarMoneyFromOthers(param1:int) : void
      {
         _getStarMoneyFromOthers = param1;
      }
      
      public function get vipPoints() : int
      {
         return _vipPoints;
      }
      
      public function set vipPoints(param1:int) : void
      {
         _vipPoints = param1;
      }
      
      public function get countHeroes() : int
      {
         return _countHeroes;
      }
      
      public function set countHeroes(param1:int) : void
      {
         _countHeroes = param1;
      }
      
      public function get power() : int
      {
         return _power;
      }
      
      public function set power(param1:int) : void
      {
         _power = param1;
      }
      
      public function get currentServerId() : int
      {
         return _currentServerId;
      }
      
      public function set currentServerId(param1:int) : void
      {
         _currentServerId = param1;
      }
      
      override public function parse(param1:Object) : void
      {
         super.parse(param1);
         if(param1.hasOwnProperty("getStarMoneyFromOthers"))
         {
            getStarMoneyFromOthers = param1.getStarMoneyFromOthers;
         }
         if(param1.hasOwnProperty("giveStarMoneyToOthers"))
         {
            giveStarMoneyToOthers = param1.giveStarMoneyToOthers;
         }
         if(param1.hasOwnProperty("vipPoints"))
         {
            vipPoints = param1.vipPoints;
         }
         if(param1.hasOwnProperty("countHeroes"))
         {
            countHeroes = param1.countHeroes;
         }
         if(param1.hasOwnProperty("power"))
         {
            power = param1.power;
         }
         if(param1.hasOwnProperty("currentServerId"))
         {
            currentServerId = param1.currentServerId;
         }
      }
   }
}
