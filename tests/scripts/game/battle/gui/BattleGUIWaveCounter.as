package game.battle.gui
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class BattleGUIWaveCounter extends GuiClipNestedContainer
   {
       
      
      public var wave_dot_inst1:BattleGUIWaveCounterDot;
      
      public var wave_dot_inst2:BattleGUIWaveCounterDot;
      
      public var wave_dot_inst3:BattleGUIWaveCounterDot;
      
      public var waveBG:ClipSprite;
      
      private var _waveNumber:int = -1;
      
      public function BattleGUIWaveCounter()
      {
         super();
      }
      
      public function get waveNumber() : int
      {
         return _waveNumber;
      }
      
      public function set waveNumber(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         if(_waveNumber == param1)
         {
            return;
         }
         _waveNumber = param1;
         var _loc2_:int = 3;
         _loc4_ = 1;
         while(_loc4_ <= _loc2_)
         {
            _loc3_ = this["wave_dot_inst" + _loc4_];
            _loc3_.WaveActive_inst0.graphics.visible = _loc4_ == param1;
            _loc3_.WaveActiveBG_inst0.graphics.visible = _loc4_ == param1;
            _loc3_.WaveSelect_inst0.graphics.visible = _loc4_ == param1;
            _loc3_.WaveInactive_inst0.graphics.visible = _loc4_ > param1;
            _loc3_.WaveInactiveBG_inst0.graphics.visible = _loc4_ > param1;
            _loc3_.WaveKilled_inst0.graphics.visible = _loc4_ < param1;
            _loc3_.WaveKilledBG_inst0.graphics.visible = _loc4_ < param1;
            _loc4_++;
         }
      }
   }
}
