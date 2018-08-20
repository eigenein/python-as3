package game.mechanics.boss.popup
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class BossChestPanelFreeClip extends GuiClipNestedContainer
   {
       
      
      public var current:Vector.<GuiAnimation>;
      
      public var opened:Vector.<GuiAnimation>;
      
      public function BossChestPanelFreeClip()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
      
      public function setStatic(param1:Boolean) : void
      {
      }
   }
}
