package game.view.popup.ny.giftinfo
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupTitle;
   
   public class NYGiftInfoPopup extends ClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:NYGiftInfoPopupMediator;
      
      private var clip:NYGiftInfoPopupClip;
      
      private var header:PopupTitle;
      
      public function NYGiftInfoPopup(param1:NYGiftInfoPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc2_:Vector.<InventoryItem> = mediator.lootBoxItems;
         var _loc3_:* = _loc2_.length <= 6;
         clip = AssetStorage.rsx.ny_gifts.create(NYGiftInfoPopupClip,!!_loc3_?"ny_small_gift_info":"ny_gift_info");
         addChild(clip.graphics);
         centerPopupBy(clip.dialog_frame.graphics,0,0);
         header = PopupTitle.create(mediator.giftTitle,clip.header_layout_container);
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_desc.text = Translate.translate("UI_DIALOG_NY_GIFT_INFO_DESC");
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         clip.gradient_top.graphics.visible = false;
         clip.gradient_bottom.graphics.visible = false;
         var _loc5_:GameScrolledList = new GameScrolledList(_loc1_,null,null);
         _loc5_.itemRendererType = NYGiftLootBoxItemRenderer;
         _loc5_.dataProvider = new ListCollection(_loc2_);
         var _loc4_:TiledRowsLayout = new TiledRowsLayout();
         _loc4_.horizontalGap = 10;
         _loc4_.verticalGap = 10;
         _loc5_.layout = _loc4_;
         if(!_loc3_)
         {
            _loc5_.width = clip.list_container.width;
            _loc5_.height = clip.list_container.height;
         }
         clip.list_container.addChild(_loc5_);
         _loc1_.validate();
         _loc5_.validate();
         if(_loc1_.value == _loc1_.maximum)
         {
            _loc1_.graphics.visible = false;
         }
      }
   }
}
