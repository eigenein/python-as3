package game.view.popup.threeboxes
{
   import engine.core.clipgui.GuiClipContainer;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipListWithScroll;
   import game.view.gui.components.GameScrollBar;
   import game.view.popup.refillable.CostButton;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class ThreeBoxesFullScreenPopUpCurrentBoxClip extends PopupClipBase
   {
       
      
      public var reward_text:ClipLabel;
      
      public var btn_back:ClipButtonLabeled;
      
      public var scrollbar:GameScrollBar;
      
      public var list:ClipListWithScroll;
      
      public var list_item:ClipDataProvider;
      
      public var tf_open_single:ClipLabel;
      
      public var tf_open_pack:ClipLabel;
      
      public var tf_cooldown:ClipLabel;
      
      public var tf_discount:ClipLabel;
      
      public var cost_button_pack:CostButton;
      
      public var cost_button_single:CostButton;
      
      public var free_button_single:ClipButtonLabeled;
      
      public var animation_place_holder:GuiClipContainer;
      
      public function ThreeBoxesFullScreenPopUpCurrentBoxClip()
      {
         reward_text = new ClipLabel();
         btn_back = new ClipButtonLabeled();
         scrollbar = new GameScrollBar();
         list = new ClipListWithScroll(InventoryItemRenderer,scrollbar);
         list_item = list.itemClipProvider;
         tf_open_single = new ClipLabel();
         tf_open_pack = new ClipLabel();
         tf_cooldown = new ClipLabel();
         tf_discount = new ClipLabel();
         cost_button_pack = new CostButton();
         cost_button_single = new CostButton();
         free_button_single = new ClipButtonLabeled();
         animation_place_holder = new GuiClipContainer();
         super();
      }
   }
}
