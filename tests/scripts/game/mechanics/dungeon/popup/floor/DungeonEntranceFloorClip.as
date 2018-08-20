package game.mechanics.dungeon.popup.floor
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   
   public class DungeonEntranceFloorClip extends DungeonBattleFloorWithStairsClip
   {
       
      
      public var save_display_door:DungeonSaveDoorDisplayClip;
      
      public var animation_portal:GuiAnimation;
      
      public var animation_portal_closing:GuiAnimation;
      
      public var door_anim:GuiAnimation;
      
      public function DungeonEntranceFloorClip()
      {
         save_display_door = new DungeonSaveDoorDisplayClip();
         animation_portal = new GuiAnimation();
         animation_portal_closing = new GuiAnimation();
         door_anim = new GuiAnimation();
         super();
         frontContainer.touchable = false;
      }
      
      public function get animationDuration() : Number
      {
         return door_anim.lastFrame / 60 * door_anim.playbackSpeed;
      }
      
      public function action_setSaveIsCaptured(param1:Boolean) : void
      {
         save_display_door.stop();
         if(param1)
         {
            if(door_anim.isCreated)
            {
               door_anim.gotoAndStop(door_anim.lastFrame);
            }
         }
         else if(door_anim.isCreated)
         {
            door_anim.gotoAndStop(1);
         }
      }
      
      public function animateSave(param1:Number = 0) : void
      {
         save_display_door.play();
         if(door_anim.isCreated)
         {
            animation_portal_closing.graphics.visible = false;
            door_anim.playOnce();
            door_anim.gotoAndPlay(param1 * 60);
            door_anim.signal_completed.addOnce(handler_doorAnimComplete);
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(animation_portal_closing.isCreated)
         {
            animation_portal_closing.playOnce();
         }
      }
      
      private function handler_doorAnimComplete() : void
      {
         save_display_door.animation_chain.stop();
         save_display_door.animation_cog_1.stop();
         save_display_door.animation_cog_2.stop();
         save_display_door.animation_cog_3.stop();
         save_display_door.stop();
      }
   }
}
