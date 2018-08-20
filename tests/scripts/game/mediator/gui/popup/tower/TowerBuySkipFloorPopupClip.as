package game.mediator.gui.popup.tower
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.refillable.CostButton;
   
   public class TowerBuySkipFloorPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var tf_header:ClipLabel;
      
      public var tf_desc:SpecialClipLabel;
      
      public var button_cancel:ClipButtonLabeled;
      
      public var button_buy:CostButton;
      
      public var bg:GuiClipScale9Image;
      
      public function TowerBuySkipFloorPopupClip()
      {
         button_close = new ClipButton();
         tf_header = new ClipLabel();
         tf_desc = new SpecialClipLabel();
         button_cancel = new ClipButtonLabeled();
         button_buy = new CostButton();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
   }
}
