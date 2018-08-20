package game.view.popup.rating
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.rating.CommandRatingTopGetResultClanDungeonEntry;
   import game.command.rpc.rating.CommandRatingTopGetResultClanEntry;
   import game.command.rpc.rating.CommandRatingTopGetResultNYTreeDecorateActionsEntry;
   import game.mediator.gui.popup.rating.RatingPopupMediator;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupSideTab;
   import game.view.popup.common.PopupTitle;
   import starling.core.Starling;
   
   public class RatingPopup extends ClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:RatingPopupMediator;
      
      private var clip:RatingPopupClip;
      
      private var list:GameScrolledList;
      
      private var title:PopupTitle;
      
      private var toggle:ToggleGroup;
      
      public function RatingPopup(param1:RatingPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "rating";
         param1.signal_dataUpdate.add(handler_dataUpdate);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         clip.item_self.dispose();
      }
      
      override protected function initialize() : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(RatingPopupClip,"dialog_rating");
         addChild(clip.graphics);
         clip.item_self.graphics.alpha = 0;
         width = clip.dialog_frame.graphics.width - 100;
         height = clip.dialog_frame.graphics.height;
         title = PopupTitle.create(mediator.title,clip.header_layout_container);
         clip.button_close.signal_click.add(mediator.close);
         var _loc3_:GameScrollBar = new GameScrollBar();
         _loc3_.height = clip.scroll_slider_container.container.height;
         clip.scroll_slider_container.container.addChild(_loc3_);
         var _loc1_:VerticalLayout = new VerticalLayout();
         var _loc6_:int = 10;
         _loc1_.paddingBottom = _loc6_;
         _loc1_.paddingTop = _loc6_;
         _loc1_.gap = 4;
         clip.item_self.button_no_clan.initialize(Translate.translate("UI_DIALOG_RATING_CLAN_GO"),mediator.action_toClans);
         clip.item_self.tf_no_clan.text = Translate.translate("UI_DIALOG_RATING_NO_CLAN_MESSAGE");
         list = new GameScrolledList(_loc3_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         list.layout = _loc1_;
         list.width = clip.list_container.container.width;
         list.height = clip.list_container.container.height;
         list.itemRendererType = RatingPopupListItemRenderer;
         clip.list_container.container.addChild(list);
         toggle = new ToggleGroup();
         var _loc2_:int = mediator.tabs.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = createButton(mediator.tabs[_loc4_]);
            toggle.addItem(_loc5_);
            clip.layout_tabs.addChild(_loc5_.graphics);
            _loc4_++;
         }
         mediator.signal_tabSet.add(handler_tabSet);
         updateNoDataState(false);
         toggle.signal_updateSelectedItem.add(handler_tabSelected);
      }
      
      private function createButton(param1:String) : PopupSideTab
      {
         var _loc2_:PopupSideTab = AssetStorage.rsx.popup_theme.create(PopupSideTab,"dialog_side_tab_shop");
         _loc2_.label = Translate.translate("UI_DIALOG_RATING_TAB_" + param1.toUpperCase());
         return _loc2_;
      }
      
      private function updateNoDataState(param1:Boolean) : void
      {
         clip.delta.graphics.visible = param1;
         clip.item_self.setupBlockVisibility(false,false);
         if(!param1)
         {
            clip.item_self.button_no_clan.graphics.visible = false;
            clip.item_self.button_no_clan.graphics.touchable = false;
            clip.item_self.tf_no_clan.visible = false;
            clip.item_self.tf_label_place.visible = false;
            clip.item_self.tf_label_rating_value.visible = false;
            clip.item_self.tf_level.visible = false;
            clip.item_self.tf_name.visible = false;
            clip.item_self.tf_no_level.visible = false;
            clip.item_self.tf_rating_value.visible = false;
         }
      }
      
      private function handler_dataUpdate() : void
      {
         updateNoDataState(true);
         if(list.dataProvider == null)
         {
            list.alpha = 0;
            Starling.juggler.tween(list,0.5,{
               "alpha":1,
               "transition":"easeOut"
            });
            Starling.juggler.tween(clip.item_self.graphics,0.3,{
               "alpha":1,
               "transition":"easeOut"
            });
         }
         list.dataProvider = new ListCollection(mediator.dataList);
         clip.item_self.commitData(mediator.playerPlaceEntry);
         clip.delta.commitData(mediator.playerDelta);
         title.text = mediator.title;
         var _loc1_:Boolean = (mediator.playerPlaceEntry is CommandRatingTopGetResultClanEntry || mediator.playerPlaceEntry is CommandRatingTopGetResultClanDungeonEntry || mediator.playerPlaceEntry is CommandRatingTopGetResultNYTreeDecorateActionsEntry) && mediator.playerPlaceEntry.place == 0;
         clip.item_self.setupBlockVisibility(!_loc1_,_loc1_);
      }
      
      private function handler_tabSelected() : void
      {
         mediator.action_tabSelect(toggle.selectedIndex);
      }
      
      private function handler_tabSet() : void
      {
         toggle.selectedIndex = mediator.selectedTab;
      }
   }
}
