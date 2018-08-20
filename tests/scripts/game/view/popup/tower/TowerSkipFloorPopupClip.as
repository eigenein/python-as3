package game.view.popup.tower
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   
   public class TowerSkipFloorPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var tf_desc:SpecialClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_points:ClipLabel;
      
      public var tf_points:ClipLabel;
      
      public var tf_skulls:ClipLabel;
      
      public var btn_fight:ClipButtonLabeled;
      
      public var btn_skip:ClipButtonLabeled;
      
      public var bg:GuiClipScale9Image;
      
      public function TowerSkipFloorPopupClip()
      {
         button_close = new ClipButton();
         tf_desc = new SpecialClipLabel();
         tf_header = new ClipLabel();
         tf_label_points = new ClipLabel();
         tf_points = new ClipLabel();
         tf_skulls = new ClipLabel();
         btn_fight = new ClipButtonLabeled();
         btn_skip = new ClipButtonLabeled();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
   }
}
