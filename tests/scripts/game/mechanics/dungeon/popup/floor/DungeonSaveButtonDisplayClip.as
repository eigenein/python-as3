package game.mechanics.dungeon.popup.floor
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class DungeonSaveButtonDisplayClip extends GuiClipNestedContainer
   {
       
      
      public var button:DungeonSaveLeverClipButton;
      
      public var mouse_disabled_sprite:Vector.<ClipSprite>;
      
      public var animation_chain:GuiAnimation;
      
      public var animation_cog_1:GuiAnimation;
      
      public var animation_cog_2:GuiAnimation;
      
      public function DungeonSaveButtonDisplayClip()
      {
         button = new DungeonSaveLeverClipButton();
         mouse_disabled_sprite = new Vector.<ClipSprite>();
         animation_chain = new GuiAnimation();
         animation_cog_1 = new GuiAnimation();
         animation_cog_2 = new GuiAnimation();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         stop();
         animation_chain.gotoAndStop(4);
      }
      
      public function playLoop() : void
      {
         if(animation_chain.isCreated)
         {
            button.animation_handle.playLoop();
            animation_chain.playLoop();
            animation_cog_1.playLoop();
            animation_cog_2.playLoop();
         }
      }
      
      public function stop() : void
      {
         if(animation_chain.isCreated)
         {
            button.animation_handle.stop();
            animation_chain.stop();
            animation_cog_1.stop();
            animation_cog_2.stop();
         }
      }
   }
}
