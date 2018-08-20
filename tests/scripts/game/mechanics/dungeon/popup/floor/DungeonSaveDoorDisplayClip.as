package game.mechanics.dungeon.popup.floor
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class DungeonSaveDoorDisplayClip extends GuiClipNestedContainer
   {
       
      
      public var mouse_disabled_sprite:Vector.<ClipSprite>;
      
      public var animation_chain:GuiAnimation;
      
      public var animation_cog_1:GuiAnimation;
      
      public var animation_cog_2:GuiAnimation;
      
      public var animation_cog_3:GuiAnimation;
      
      public function DungeonSaveDoorDisplayClip()
      {
         mouse_disabled_sprite = new Vector.<ClipSprite>();
         animation_chain = new GuiAnimation();
         animation_cog_1 = new GuiAnimation();
         animation_cog_2 = new GuiAnimation();
         animation_cog_3 = new GuiAnimation();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         stop();
      }
      
      public function playOnce() : void
      {
         if(animation_chain.isCreated)
         {
            animation_chain.playOnce();
            animation_cog_1.playOnce();
            animation_cog_2.playOnce();
            animation_cog_3.playOnce();
         }
      }
      
      public function play() : void
      {
         if(animation_chain.isCreated)
         {
            animation_chain.play();
            animation_cog_1.play();
            animation_cog_2.play();
            animation_cog_3.play();
         }
      }
      
      public function stop() : void
      {
         if(animation_chain.isCreated)
         {
            animation_chain.stop();
            animation_cog_1.stop();
            animation_cog_2.stop();
            animation_cog_3.stop();
         }
      }
   }
}
