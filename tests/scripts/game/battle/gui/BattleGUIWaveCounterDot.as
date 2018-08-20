package game.battle.gui
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class BattleGUIWaveCounterDot extends GuiClipNestedContainer
   {
      
      public static const STATE_CURRENT:String = "STATE_CURRENT";
      
      public static const STATE_COMPLETED:String = "STATE_COMPLETED";
      
      public static const STATE_NOT_COMPLETED:String = "STATE_NOT_COMPLETED";
       
      
      public var WaveSelect_inst0:ClipSprite;
      
      public var WaveKilled_inst0:ClipSprite;
      
      public var WaveKilledBG_inst0:ClipSprite;
      
      public var WaveInactive_inst0:ClipSprite;
      
      public var WaveInactiveBG_inst0:ClipSprite;
      
      public var WaveActive_inst0:ClipSprite;
      
      public var WaveActiveBG_inst0:ClipSprite;
      
      public function BattleGUIWaveCounterDot()
      {
         super();
      }
   }
}
