package game.view.popup.mail
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.mail.PlayerMailEntryValueObject;
   import game.mediator.gui.popup.mail.PlayerMailPopupMeditator;
   import game.view.gui.components.GameScrollBar;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import starling.events.Event;
   
   public class PlayerMailPopup extends ClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:PlayerMailPopupMeditator;
      
      private var clip:PlayerMailPopupClip;
      
      private var list:PlayerMailList;
      
      private var slider:GameScrollBar;
      
      public function PlayerMailPopup(param1:PlayerMailPopupMeditator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "mail";
         param1.signal_mailDeleted.add(handler_mailDeleted);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_mail();
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_no_new_mail.text = Translate.translate("UI_DIALOG_MAIL_EMPTY");
         clip.button_farm_all.label = Translate.translate("UI_DIALOG_MAIL_FARM_ALL");
         clip.title = Translate.translate("UI_DIALOG_MAIL_TITLE");
         slider = new GameScrollBar();
         slider.height = clip.scroll_slider_container.container.height;
         clip.scroll_slider_container.container.addChild(slider);
         list = new PlayerMailList(slider,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         list.width = clip.list_container.container.width;
         list.height = clip.list_container.container.height;
         list.addEventListener("rendererAdd",onListRendererAdded);
         list.addEventListener("rendererRemove",onListRendererRemoved);
         mediator.data.addEventListener("change",handler_dataSetChange);
         list.dataProvider = mediator.data;
         clip.list_container.container.addChild(list);
         clip.button_farm_all.signal_click.add(mediator.action_mailSelectAll);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         checkIfEmpty();
      }
      
      private function checkIfEmpty() : void
      {
         var _loc1_:* = mediator.data.length == 0;
         clip.tf_no_new_mail.visible = _loc1_;
         list.visible = !_loc1_;
         clip.button_farm_all.graphics.visible = mediator.canMultiFarm;
         slider.visible = !_loc1_;
      }
      
      private function onListRendererAdded(param1:Event, param2:PlayerMailListItemRenderer) : void
      {
         param2.signal_select.add(onSelectSignal);
      }
      
      private function onSelectSignal(param1:PlayerMailEntryValueObject) : void
      {
         mediator.action_mailSelect(param1);
      }
      
      private function onListRendererRemoved(param1:Event, param2:PlayerMailListItemRenderer) : void
      {
         param2.signal_select.remove(onSelectSignal);
      }
      
      private function handler_mailDeleted(param1:PlayerMailEntryValueObject) : void
      {
      }
      
      private function handler_dataSetChange(param1:Event) : void
      {
         checkIfEmpty();
      }
   }
}
