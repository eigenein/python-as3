package game.view.popup.threeboxes
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ThreeBoxesFullScreenPopUpClip extends PopupClipBase
   {
       
      
      public var timer_text:SpecialClipLabel;
      
      public var marker:ClipSprite;
      
      public var info_text:ClipLabel;
      
      public var layout_info:ClipLayout;
      
      public var tf_box_1:ClipLabel;
      
      public var tf_box_2:ClipLabel;
      
      public var tf_box_3:ClipLabel;
      
      public var layout_box_1:ClipLayout;
      
      public var layout_box_2:ClipLayout;
      
      public var layout_box_3:ClipLayout;
      
      public var button_open_1:ClipButtonLabeled;
      
      public var button_open_2:ClipButtonLabeled;
      
      public var button_open_3:ClipButtonLabeled;
      
      public var marker_button_open_1:ClipSprite;
      
      public var marker_button_open_2:ClipSprite;
      
      public var marker_button_open_3:ClipSprite;
      
      public var three_boxes_place_holder:GuiClipContainer;
      
      public function ThreeBoxesFullScreenPopUpClip()
      {
         timer_text = new SpecialClipLabel();
         marker = new ClipSprite();
         info_text = new ClipLabel(true);
         layout_info = ClipLayout.horizontalMiddleCentered(5,marker,info_text);
         tf_box_1 = new ClipLabel();
         tf_box_2 = new ClipLabel();
         tf_box_3 = new ClipLabel();
         layout_box_1 = ClipLayout.horizontalMiddleCentered(8);
         layout_box_2 = ClipLayout.horizontalMiddleCentered(8);
         layout_box_3 = ClipLayout.horizontalMiddleCentered(8);
         button_open_1 = new ClipButtonLabeled();
         button_open_2 = new ClipButtonLabeled();
         button_open_3 = new ClipButtonLabeled();
         marker_button_open_1 = new ClipSprite();
         marker_button_open_2 = new ClipSprite();
         marker_button_open_3 = new ClipSprite();
         three_boxes_place_holder = new GuiClipContainer();
         super();
      }
   }
}
