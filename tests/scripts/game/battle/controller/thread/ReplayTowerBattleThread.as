package game.battle.controller.thread
{
   import battle.BattleConfig;
   import battle.BattleLog;
   import battle.log.BattleLogEncoder;
   import battle.log.BattleLogEvent;
   import battle.log.BattleLogNameResolver;
   import battle.log.BattleLogReader;
   
   public class ReplayTowerBattleThread extends TowerBattleThread
   {
       
      
      public function ReplayTowerBattleThread(param1:Object)
      {
         version = parseServerVersion(param1.result);
         super(param1);
         replayProgress = param1.progress;
      }
      
      override protected function onBattleLogInitiated() : void
      {
         BattleLog.clear();
         BattleLog.doLog = true;
      }
      
      override protected function onBattleLogAvailable() : void
      {
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         _loc5_ = 0;
         var _loc3_:* = null;
         var _loc4_:String = BattleLog.getLog();
         var _loc9_:int = 200;
         _loc8_ = _loc4_.length / _loc9_;
         _loc5_ = 0;
         while(_loc5_ <= _loc8_)
         {
            _loc4_ = _loc4_.slice(0,_loc5_ * _loc9_ + _loc5_) + "\n" + _loc4_.slice(_loc5_ * _loc9_ + _loc5_);
            _loc5_++;
         }
         trace("battleLog: " + _loc4_.length + " chars " + _loc8_ + " rows");
         _loc4_ = _loc4_.replace(/\n/g,"");
         var _loc6_:Vector.<BattleLogEvent> = BattleLogEncoder.read(new BattleLogReader(_loc4_));
         _loc8_ = _loc6_.length;
         var _loc2_:String = "";
         var _loc1_:BattleLogNameResolver = new BattleLogNameResolver();
         var _loc7_:Number = NaN;
         _loc5_ = 0;
         while(_loc5_ < _loc8_)
         {
            _loc3_ = _loc6_[_loc5_];
            if(_loc7_ != _loc3_.time)
            {
               _loc7_ = _loc3_.time;
               _loc2_ = _loc2_ + (_loc7_ + ":\n");
            }
            _loc2_ = _loc2_ + ("   " + _loc3_.toStringShort() + "\n");
            _loc5_++;
         }
      }
      
      override protected function createBattlePresets(param1:BattleConfig) : BattlePresets
      {
         return new BattlePresets(true,false,false,param1);
      }
   }
}
