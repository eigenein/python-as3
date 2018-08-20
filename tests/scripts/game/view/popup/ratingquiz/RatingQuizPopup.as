package game.view.popup.ratingquiz
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.rating.CommandRatingTopGetResultClanDungeonEntry;
   import game.command.rpc.rating.CommandRatingTopGetResultClanEntry;
   import game.command.rpc.rating.CommandRatingTopGetResultNYTreeDecorateActionsEntry;
   import game.mediator.gui.popup.ratingquiz.RatingQuizPopupMediator;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupTitle;
   import game.view.popup.rating.RatingPopupClip;
   import starling.core.Starling;
   
   public class RatingQuizPopup extends ClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:RatingQuizPopupMediator;
      
      private var clip:RatingPopupClip;
      
      private var list:GameScrolledList;
      
      private var title:PopupTitle;
      
      public function RatingQuizPopup(param1:RatingQuizPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "rating_quiz";
         param1.signal_dataUpdate.add(handler_dataUpdate);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         clip.item_self.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(RatingPopupClip,"dialog_rating");
         addChild(clip.graphics);
         clip.item_self.graphics.alpha = 0;
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         title = PopupTitle.create(mediator.title,clip.header_layout_container);
         clip.button_close.signal_click.add(mediator.close);
         var _loc2_:GameScrollBar = new GameScrollBar();
         _loc2_.height = clip.scroll_slider_container.container.height;
         clip.scroll_slider_container.container.addChild(_loc2_);
         var _loc1_:VerticalLayout = new VerticalLayout();
         var _loc3_:int = 10;
         _loc1_.paddingBottom = _loc3_;
         _loc1_.paddingTop = _loc3_;
         _loc1_.gap = 4;
         clip.item_self.button_no_clan.initialize(Translate.translate("UI_DIALOG_RATING_CLAN_GO"),mediator.action_toClans);
         clip.item_self.tf_no_clan.text = Translate.translate("UI_DIALOG_RATING_NO_CLAN_MESSAGE");
         list = new GameScrolledList(_loc2_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         list.layout = _loc1_;
         list.width = clip.list_container.container.width;
         list.height = clip.list_container.container.height;
         list.itemRendererType = RatingQuizPopupListItemRenderer;
         clip.list_container.container.addChild(list);
         mediator.action_getRating();
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
   }
}
