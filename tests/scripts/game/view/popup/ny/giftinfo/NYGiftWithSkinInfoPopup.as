package game.view.popup.ny.giftinfo
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.skin.SkinDescription;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupTitle;
   
   public class NYGiftWithSkinInfoPopup extends ClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:NYGiftInfoPopupMediator;
      
      private var clip:NYGiftWithSkinInfoPopupClip;
      
      private var header:PopupTitle;
      
      public function NYGiftWithSkinInfoPopup(param1:NYGiftInfoPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < clip.skin_.length)
         {
            clip.skin_[_loc1_].dispose();
            _loc1_++;
         }
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         var _loc4_:int = 0;
         super.initialize();
         clip = AssetStorage.rsx.ny_gifts.create(NYGiftWithSkinInfoPopupClip,"ny_gift_with_skin_info");
         addChild(clip.graphics);
         centerPopupBy(clip.dialog_frame.graphics,0,0);
         header = PopupTitle.create(mediator.giftTitle,clip.header_layout_container);
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_skin_title.text = Translate.translate("UI_DIALOG_NY_GIFT_WITH_SKIN_INFO_SKIN_TITLE");
         clip.tf_skin_desc.text = Translate.translate("UI_DIALOG_NY_GIFT_WITH_SKIN_INFO_SKIN_DESC");
         clip.tf_desc.text = Translate.translate("UI_DIALOG_NY_GIFT_WITH_SKIN_INFO_DESC");
         var _loc1_:Vector.<SkinDescription> = mediator.skins;
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            clip.skin_[_loc4_].setData(_loc1_[_loc4_]);
            clip.skin_[_loc4_].signal_click.add(mediator.action_showSkinInfo);
            _loc4_++;
         }
         var _loc2_:List = new List();
         _loc2_.itemRendererType = NYGiftLootBoxItemRenderer;
         _loc2_.dataProvider = new ListCollection(mediator.rewardItems);
         _loc2_.verticalScrollPolicy = "off";
         if(_loc2_.dataProvider.length >= 6)
         {
            _loc2_.width = clip.list_container.width;
         }
         _loc2_.height = clip.list_container.height;
         var _loc3_:TiledRowsLayout = new TiledRowsLayout();
         _loc3_.horizontalGap = 10;
         _loc3_.verticalGap = 10;
         _loc3_.horizontalAlign = "center";
         _loc3_.verticalAlign = "middle";
         _loc2_.layout = _loc3_;
         clip.list_container.addChild(_loc2_);
      }
   }
}
