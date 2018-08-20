package game.mechanics.dungeon.popup.floor
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import starling.core.Starling;
   
   public class DungeonLeverFloorClip extends DungeonBattleFloorWithStairsClip
   {
       
      
      public var save_display_button:DungeonSaveButtonDisplayClip;
      
      public var animation_save_chains:GuiAnimation;
      
      public function DungeonLeverFloorClip()
      {
         save_display_button = new DungeonSaveButtonDisplayClip();
         animation_save_chains = new GuiAnimation();
         super();
      }
      
      public function get animationDuration() : Number
      {
         return 4;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         save_display_button.button.isEnabled = false;
         save_display_button.stop();
         animation_save_chains.stop();
      }
      
      public function animateSave(param1:Number = 0) : void
      {
         save_display_button.playLoop();
         animation_save_chains.playLoop();
         Starling.juggler.delayCall(stop,animationDuration - param1);
      }
      
      public function action_saveCanBeCaptured(param1:Boolean) : void
      {
         save_display_button.button.isEnabled = param1;
      }
      
      public function action_setSaveIsCaptured(param1:Boolean) : void
      {
      }
      
      public function action_activateLever() : void
      {
         save_display_button.button.isEnabled = true;
      }
      
      private function stop() : void
      {
         save_display_button.stop();
         animation_save_chains.stop();
      }
   }
}
