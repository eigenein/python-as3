package game.view.popup.clan.editicon
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipList;
   import game.view.popup.shop.ShopCostPanel;
   
   public class ClanEditIconPopupClip extends PopupClipBase
   {
       
      
      public var button_confirm:ClipButtonLabeled;
      
      public var cost:ShopCostPanel;
      
      public var tf_label_canvas:ClipLabel;
      
      public var tf_label_symbol:ClipLabel;
      
      public var tf_label_result:ClipLabel;
      
      public var list_canvas:ClipList;
      
      public var item_canvas:ClipDataProvider;
      
      public var button_canvas_right:ClipButton;
      
      public var button_canvas_left:ClipButton;
      
      public var list_emblem:ClipList;
      
      public var item_emblem:ClipDataProvider;
      
      public var button_emblem_right:ClipButton;
      
      public var button_emblem_left:ClipButton;
      
      public var color1:ClanEditIconColorList;
      
      public var color2:ClanEditIconColorList;
      
      public var color3:ClanEditIconColorList;
      
      public var layout_result:ClipLayout;
      
      public var layout_mini:ClipLayout;
      
      public function ClanEditIconPopupClip()
      {
         list_canvas = new ClipList(ClipListItemClanEditIconCanvas);
         item_canvas = list_canvas.itemClipProvider;
         list_emblem = new ClipList(ClipListItemClanEditIconEmblem);
         item_emblem = list_emblem.itemClipProvider;
         layout_result = ClipLayout.horizontalMiddleCentered(0);
         layout_mini = ClipLayout.horizontalMiddleCentered(0);
         super();
      }
   }
}
