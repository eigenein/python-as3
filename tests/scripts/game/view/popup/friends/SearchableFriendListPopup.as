package game.view.popup.friends
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.TiledRowsLayout;
   import game.mediator.gui.popup.friends.FriendDataProvider;
   import game.mediator.gui.popup.friends.SearchableFriendListPopupMediatorBase;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.friends.referrer.ReferrerPopupListItemRenderer;
   import starling.events.Event;
   
   public class SearchableFriendListPopup extends ClipBasedPopup
   {
       
      
      private var mediator:SearchableFriendListPopupMediatorBase;
      
      protected var clip:SearchableFriendListPopupClipBase;
      
      protected var list:GameScrolledList;
      
      public function SearchableFriendListPopup(param1:SearchableFriendListPopupMediatorBase)
      {
         super(param1);
         this.mediator = param1;
      }
      
      public function get listItemRendererType() : Class
      {
         return ReferrerPopupListItemRenderer;
      }
      
      public function get searchInputDefaultText() : String
      {
         return Translate.translate("UI_DIALOG_SEARCHABLE_FRIENDS_PROMPT");
      }
      
      protected function updateListData(param1:Boolean) : void
      {
         list.dataProvider = mediator.friendList;
         clip.tf_empty.visible = mediator.friendList.length == 0;
         if(mediator.friendList.length == 0)
         {
            if(param1)
            {
               clip.tf_empty.text = Translate.translate("UI_DIALOG_REFERRER_SEARCH_EMPTY");
            }
            else
            {
               clip.tf_empty.text = Translate.translate("UI_DIALOG_REFERRER_EMPTY");
            }
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         createClip();
         addChild(clip.graphics);
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
         clip.button_close.signal_click.add(mediator.close);
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         clip.tf_name_input.addEventListener("change",handler_inputChange);
         clip.tf_name_input.prompt = searchInputDefaultText;
         list = new GameScrolledList(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         list.width = clip.list_container.container.width;
         list.height = clip.list_container.container.height;
         clip.list_container.container.addChild(list);
         list.addEventListener("rendererAdd",onListRendererAdded);
         list.addEventListener("rendererRemove",onListRendererRemoved);
         list.addEventListener("change",onListSelectionChange);
         var _loc2_:TiledRowsLayout = list.layout as TiledRowsLayout;
         _loc2_.padding = 10;
         var _loc3_:int = 20;
         _loc2_.paddingBottom = _loc3_;
         _loc2_.paddingTop = _loc3_;
         _loc2_.gap = 10;
         list.itemRendererType = listItemRendererType;
         updateListData(false);
         mediator.signal_updateData.add(handler_searchDataUpdate);
      }
      
      protected function createClip() : void
      {
      }
      
      protected function handler_searchDataUpdate(param1:Boolean) : void
      {
         updateListData(!param1);
      }
      
      protected function handler_inputChange(param1:Event) : void
      {
         mediator.action_searchUpdate(clip.tf_name_input.text);
      }
      
      protected function onListRendererAdded(param1:Event, param2:ReferrerPopupListItemRenderer) : void
      {
         param2.signal_select.add(handler_select);
      }
      
      protected function onListRendererRemoved(param1:Event, param2:ReferrerPopupListItemRenderer) : void
      {
         param2.signal_select.remove(handler_select);
      }
      
      protected function onListSelectionChange(param1:Event) : void
      {
      }
      
      protected function handler_select(param1:FriendDataProvider) : void
      {
      }
   }
}
