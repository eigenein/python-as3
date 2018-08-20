package game.view.popup.tower
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class TowerSkipPopupClip extends PopupClipBase
   {
       
      
      public var button_tower_skip_full_inst0:TowerSkipPopupCostButton;
      
      public var button_tower_skip_inst0:ClipButtonLabeled;
      
      public var tf_desc:ClipLabel;
      
      public var tf_open_all_desc:ClipLabel;
      
      public var tf_ribbon_all:ClipLabel;
      
      public var tf_ribbon_select:ClipLabel;
      
      public var tf_select_desc:ClipLabel;
      
      public var chest_blue:GuiClipNestedContainer;
      
      public var chest_gold:GuiClipNestedContainer;
      
      public function TowerSkipPopupClip()
      {
         button_tower_skip_full_inst0 = new TowerSkipPopupCostButton();
         button_tower_skip_inst0 = new ClipButtonLabeled();
         tf_desc = new ClipLabel();
         tf_open_all_desc = new ClipLabel();
         tf_ribbon_all = new ClipLabel();
         tf_ribbon_select = new ClipLabel();
         tf_select_desc = new ClipLabel();
         chest_blue = new GuiClipNestedContainer();
         chest_gold = new GuiClipNestedContainer();
         super();
      }
   }
}
