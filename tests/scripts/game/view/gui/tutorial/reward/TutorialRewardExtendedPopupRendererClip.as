package game.view.gui.tutorial.reward
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipScale9Image;
   import engine.core.clipgui.INeedNestedParsing;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class TutorialRewardExtendedPopupRendererClip extends GuiClipLayoutContainer implements INeedNestedParsing
   {
       
      
      public const tf_desc:ClipLabel = new ClipLabel();
      
      public const tf_name:ClipLabel = new ClipLabel();
      
      public const bg:GuiClipScale9Image = new GuiClipScale9Image();
      
      public const item:InventoryItemRenderer = new InventoryItemRenderer();
      
      public const animation_highlight:GuiAnimation = new GuiAnimation();
      
      public const layout_animation:ClipLayout = ClipLayout.none(animation_highlight);
      
      public function TutorialRewardExtendedPopupRendererClip()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         graphics.width = bg.graphics.width;
         graphics.height = bg.graphics.height;
         animation_highlight.stop();
         animation_highlight.graphics.visible = false;
         layout_animation.includeInLayout = false;
      }
      
      public function setData(param1:TutorialRewardExtendedPopupValueObject) : void
      {
         item.setData(param1.item);
         tf_desc.text = param1.desc;
         tf_name.text = param1.item.name;
         if(param1.isHighlighted)
         {
            animation_highlight.graphics.visible = true;
            animation_highlight.playLoop();
         }
         else
         {
            animation_highlight.stop();
            animation_highlight.graphics.visible = false;
         }
      }
   }
}
