package game.view.popup.ny.gifts
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetProgressProvider;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.view.IDisposable;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.AsyncClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.chest.ChestPopupTitle;
   import starling.events.Event;
   
   public class NYGiftsPopup extends AsyncClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:NYGiftsPopupMediator;
      
      private var clip:NYGiftsPopupClip;
      
      private var popupTitle:ChestPopupTitle;
      
      private var tabList:GameScrolledList;
      
      private var content:IDisposable;
      
      private var progressbar:ClipProgressBar;
      
      private var assetProgress:AssetProgressProvider;
      
      public function NYGiftsPopup(param1:NYGiftsPopupMediator)
      {
         super(param1,AssetStorage.rsx.ny_gifts);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(content)
         {
            content.dispose();
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(!asset.completed)
         {
            progressbar = AssetStorage.rsx.popup_theme.create_component_progressbar();
            addChild(progressbar.graphics);
            assetProgress = AssetStorage.instance.globalLoader.getAssetProgress(asset);
            if(!assetProgress.completed)
            {
               assetProgress.signal_onProgress.add(handler_assetProgress);
               handler_assetProgress(assetProgress);
            }
         }
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         if(_isDisposed)
         {
            return;
         }
         width = 1000;
         height = 650;
         if(progressbar)
         {
            removeChild(progressbar.graphics);
         }
         var _loc2_:GuiClipNestedContainer = param1.create(GuiClipNestedContainer,"bg_graphics");
         addChild(_loc2_.graphics);
         clip = param1.create(NYGiftsPopupClip,"ny_gifts_popup_gui");
         addChild(clip.graphics);
         popupTitle = new ChestPopupTitle(Translate.translate("UI_DIALOG_NY_GIFTS_HEADER"),clip.header_layout_container);
         popupTitle.minBgWidth = 550;
         clip.button_close.signal_click.add(mediator.close);
         tabList = new GameScrolledList(null,null,null);
         tabList.layout = new HorizontalLayout();
         (tabList.layout as HorizontalLayout).gap = -4;
         tabList.itemRendererType = NYGiftsPopupTabRenderer;
         tabList.addEventListener("change",handler_changeTab);
         tabList.verticalScrollPolicy = "off";
         tabList.dataProvider = mediator.tabsListCollection;
         tabList.selectedIndex = 0;
         clip.tabs_list_container.addChild(tabList);
      }
      
      private function updateContent(param1:NYGiftsPopupTabRendererVO) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         if(content)
         {
            content.dispose();
         }
         clip.content_container.container.removeChildren();
         switch(int(param1.id))
         {
            case 0:
               _loc3_ = AssetStorage.rsx.ny_gifts.create(NYSendGiftContent,"send_gift_content");
               _loc3_.mediator = mediator;
               clip.content_container.container.addChild(_loc3_.graphics);
               content = _loc3_;
               break;
            case 1:
               _loc4_ = AssetStorage.rsx.ny_gifts.create(NYReceivedGiftsContent,"received_gifts_content");
               _loc4_.mediator = mediator;
               clip.content_container.container.addChild(_loc4_.graphics);
               content = _loc4_;
               break;
            case 2:
               _loc2_ = AssetStorage.rsx.ny_gifts.create(NYSendedGiftsContent,"sended_gifts_content");
               _loc2_.mediator = mediator;
               clip.content_container.container.addChild(_loc2_.graphics);
               content = _loc2_;
         }
      }
      
      private function handler_changeTab(param1:Event) : void
      {
         if(tabList.selectedItem)
         {
            updateContent(tabList.selectedItem as NYGiftsPopupTabRendererVO);
         }
      }
      
      private function handler_assetProgress(param1:AssetProgressProvider) : void
      {
         if(progressbar)
         {
            progressbar.maxValue = param1.progressTotal;
            progressbar.value = param1.progressCurrent;
         }
      }
   }
}
