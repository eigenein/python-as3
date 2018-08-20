package game.view.popup.blasklist
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.model.user.chat.ChatUserData;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.ClipBasedPopup;
   import starling.events.Event;
   
   public class BlackListPopUp extends ClipBasedPopup
   {
       
      
      private var mediator:BlackListPopUpClipMediator;
      
      private var clip:BlackListPopUpClip;
      
      private var blackList:GameScrolledList;
      
      public function BlackListPopUp(param1:BlackListPopUpClipMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_black_list();
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.gradient_top.graphics.visible = false;
         clip.gradient_bottom.graphics.visible = false;
         clip.tf_empty.visible = false;
         clip.tf_title.text = Translate.translate("UI_POPUP_BLACK_LIST_TITLE");
         clip.tf_desc.text = Translate.translate("UI_POPUP_BLACK_LIST_DESC");
         clip.tf_empty.text = Translate.translate("UI_POPUP_BLACK_LIST_EMPTY");
         clip.action_button.label = Translate.translate("UI_POPUP_BLACK_LIST_DROP");
         clip.action_button.signal_click.add(mediator.blackListDrop);
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         blackList = new GameScrolledList(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         blackList.isSelectable = true;
         blackList.width = clip.list_container.graphics.width;
         blackList.height = clip.list_container.graphics.height;
         blackList.itemRendererType = BlackListPopUpRenderer;
         blackList.addEventListener("rendererAdd",onListRendererAdded);
         blackList.addEventListener("rendererRemove",onListRendererRemoved);
         var _loc2_:VerticalLayout = new VerticalLayout();
         _loc2_.paddingTop = 5;
         _loc2_.paddingBottom = 5;
         _loc2_.paddingLeft = 10;
         _loc2_.gap = 6;
         blackList.layout = _loc2_;
         clip.list_container.container.addChild(blackList);
         mediator.signal_blackListUpdate.add(handler_blackListChanged);
      }
      
      private function onListRendererAdded(param1:Event, param2:BlackListPopUpRenderer) : void
      {
         param2.signal_nickClick.add(handler_rendererNickClick);
         param2.signal_buttonClick.add(handler_rendererButtonClick);
      }
      
      private function onListRendererRemoved(param1:Event, param2:BlackListPopUpRenderer) : void
      {
         param2.signal_nickClick.remove(handler_rendererNickClick);
         param2.signal_buttonClick.remove(handler_rendererButtonClick);
      }
      
      private function handler_rendererNickClick(param1:ChatUserData) : void
      {
         mediator.showUserInfo(param1);
      }
      
      private function handler_rendererButtonClick(param1:ChatUserData) : void
      {
         mediator.blackListRemove(param1.id);
      }
      
      private function handler_blackListChanged() : void
      {
         clip.gradient_top.graphics.visible = mediator.blackList.length > 0;
         clip.gradient_bottom.graphics.visible = mediator.blackList.length > 0;
         clip.tf_empty.visible = mediator.blackList.length == 0;
         blackList.dataProvider = new ListCollection(mediator.blackList);
      }
   }
}
