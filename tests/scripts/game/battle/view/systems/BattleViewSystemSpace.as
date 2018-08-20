package game.battle.view.systems
{
   import game.battle.view.BattleSceneObject;
   
   public class BattleViewSystemSpace
   {
       
      
      private var _systems:Vector.<BattleUpdateSystem>;
      
      private var advanceTimeInProcess:Boolean = false;
      
      private var _pending:Vector.<BattleSceneObject>;
      
      public function BattleViewSystemSpace()
      {
         _systems = new Vector.<BattleUpdateSystem>();
         _pending = new Vector.<BattleSceneObject>();
         super();
      }
      
      public function addSystem(param1:BattleUpdateSystem) : void
      {
         _systems.push(param1);
      }
      
      public function add(param1:BattleSceneObject) : void
      {
         var _loc3_:* = undefined;
         if(advanceTimeInProcess)
         {
            _pending.push(param1,null);
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _systems;
         for each(var _loc2_ in _systems)
         {
            _loc3_ = _loc2_.getComponentToHandle(param1);
            if(_loc3_)
            {
               _loc2_.add(_loc3_);
            }
         }
      }
      
      public function remove(param1:BattleSceneObject) : void
      {
         var _loc3_:* = undefined;
         if(advanceTimeInProcess)
         {
            _pending.push(null,param1);
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _systems;
         for each(var _loc2_ in _systems)
         {
            _loc3_ = _loc2_.getComponentToHandle(param1);
            if(_loc3_)
            {
               _loc2_.remove(_loc3_);
            }
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         checkPending();
         advanceTimeInProcess = true;
         var _loc4_:int = 0;
         var _loc3_:* = _systems;
         for each(var _loc2_ in _systems)
         {
            _loc2_.advanceTime(param1);
         }
         advanceTimeInProcess = false;
      }
      
      protected function checkPending() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = _pending.length;
         if(_loc2_ == 0)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_pending[_loc1_])
            {
               add(_pending[_loc1_]);
            }
            else
            {
               remove(_pending[_loc1_ + 1]);
            }
            _loc1_ = _loc1_ + 2;
         }
         _pending.length = 0;
      }
   }
}
