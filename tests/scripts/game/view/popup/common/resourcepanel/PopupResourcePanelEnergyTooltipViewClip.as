package game.view.popup.common.resourcepanel
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.layout.VerticalLayout;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class PopupResourcePanelEnergyTooltipViewClip extends GuiClipNestedContainer
   {
       
      
      public var tf_refill_count:SpecialClipLabel;
      
      public var tf_refill_time:SpecialClipLabel;
      
      public var tf_text:SpecialClipLabel;
      
      public var bg:GuiClipScale9Image;
      
      public var layout_main:ClipLayout;
      
      public function PopupResourcePanelEnergyTooltipViewClip()
      {
         tf_refill_count = new SpecialClipLabel(true);
         tf_refill_time = new SpecialClipLabel(true);
         tf_text = new SpecialClipLabel(true);
         layout_main = ClipLayout.verticalMiddleCenter(0,tf_text,tf_refill_time,tf_refill_count);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         layout_main.height = NaN;
         layout_main.width = NaN;
         (layout_main.layout as VerticalLayout).paddingTop = 5;
      }
   }
}
