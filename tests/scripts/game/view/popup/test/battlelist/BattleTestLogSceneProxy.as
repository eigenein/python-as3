package game.view.popup.test.battlelist
{
   import battle.Hero;
   import battle.proxy.empty.EmptySceneProxy;
   
   public class BattleTestLogSceneProxy extends EmptySceneProxy
   {
       
      
      private var _log:Vector.<Object>;
      
      private var _heroIdEnumerator:int;
      
      public function BattleTestLogSceneProxy()
      {
         _log = new Vector.<Object>();
         super();
      }
      
      override public function addHero(param1:Hero) : void
      {
         _heroIdEnumerator = Number(_heroIdEnumerator) + 1;
         param1.viewProxy = new BattleTestLogHeroProxy(this,Number(_heroIdEnumerator));
      }
      
      public function log(param1:BattleTestLogHeroProxy, param2:int, ... rest) : void
      {
         _log.push(param1.id * 100 + param2);
         var _loc6_:int = 0;
         var _loc5_:* = rest;
         for each(var _loc4_ in rest)
         {
            _log.push(_loc4_);
         }
      }
      
      public function getLog() : Vector.<Object>
      {
         return _log;
      }
      
      public function getStringLog() : String
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:String = "";
         var _loc2_:Vector.<Object> = _log.concat();
         var _loc4_:int = 0;
         var _loc7_:int = _loc2_.length;
         while(_loc4_ < _loc7_)
         {
            _loc3_ = _loc2_[_loc4_];
            _loc5_ = _loc3_ / 100;
            _loc6_ = _loc3_ % 100;
            _loc4_ = _loc4_ + (1 + BattleTestLogHeroProxy.ACTION_PARAMS_COUNT[_loc6_]);
            _loc1_ = _loc1_ + (BattleTestLogHeroProxy.ACTION_NAMES[_loc6_] + " ");
         }
         return _loc1_;
      }
   }
}
