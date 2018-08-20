package game.battle.view
{
   import battle.data.BattleSkillDescription;
   import game.battle.view.systems.IBattleDisposable;
   import org.osflash.signals.Signal;
   
   public class BattleSceneObject implements IBattleDisposable
   {
       
      
      private var _scene:BattleScene;
      
      private var _entry:IBattleDisposable;
      
      public var tickOnPause:Boolean;
      
      public var skill:BattleSkillDescription;
      
      public function BattleSceneObject(param1:IBattleDisposable)
      {
         super();
         _entry = param1;
         _entry.signal_dispose.add(handler_fxDisposed);
      }
      
      public function get signal_dispose() : Signal
      {
         return _entry.signal_dispose;
      }
      
      public function get entry() : IBattleDisposable
      {
         return _entry;
      }
      
      public function set scene(param1:BattleScene) : void
      {
         _scene = param1;
      }
      
      public function advanceTime(param1:Number) : void
      {
         _entry.advanceTime(param1);
      }
      
      private function handler_fxDisposed() : void
      {
         _entry.signal_dispose.remove(handler_fxDisposed);
         if(_scene)
         {
            _scene.removeFxObject(this);
         }
      }
   }
}
