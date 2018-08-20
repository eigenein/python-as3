package game.model.user.level
{
   import game.data.storage.DataStorage;
   import game.data.storage.level.VIPLevel;
   import idv.cjcat.signals.Signal;
   
   public class PlayerVIPLevelData
   {
       
      
      private var _signal_vipLevelUpdate:Signal;
      
      private var _vipPoints:int;
      
      public function PlayerVIPLevelData()
      {
         _signal_vipLevelUpdate = new Signal();
         super();
      }
      
      public function get signal_vipLevelUpdate() : Signal
      {
         return _signal_vipLevelUpdate;
      }
      
      public function init(param1:int) : void
      {
         this._vipPoints = param1;
      }
      
      public function get level() : VIPLevel
      {
         return DataStorage.level.getVipLevelByVipPoints(_vipPoints);
      }
      
      public function get vipPoints() : int
      {
         return _vipPoints;
      }
      
      public function addPoints(param1:int) : void
      {
         var _loc2_:VIPLevel = level;
         _vipPoints = _vipPoints + param1;
         if(_loc2_ != level)
         {
            _signal_vipLevelUpdate.dispatch();
         }
      }
   }
}
