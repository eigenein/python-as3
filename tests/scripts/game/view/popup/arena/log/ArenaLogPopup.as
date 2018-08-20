package game.view.popup.arena.log
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.arena.ArenaLogEntryVOProxy;
   import game.mediator.gui.popup.arena.ArenaLogPopupMediator;
   import game.view.gui.components.GameScrollBar;
   import game.view.popup.ClipBasedPopup;
   import starling.events.Event;
   
   public class ArenaLogPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ArenaLogPopupMediator;
      
      public function ArenaLogPopup(param1:ArenaLogPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc3_:ArenaLogPopupClip = AssetStorage.rsx.popup_theme.create_dialog_arena_log();
         addChild(_loc3_.graphics);
         _loc3_.title = Translate.translate("UI_DIALOG_LOG_ARENA_NAME");
         _loc3_.tf_message.visible = mediator.logData.length == 0;
         _loc3_.button_close.signal_click.add(mediator.close);
         width = _loc3_.dialog_frame.graphics.width;
         height = _loc3_.dialog_frame.graphics.height;
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = _loc3_.scroll_slider_container.container.height;
         _loc3_.scroll_slider_container.container.addChild(_loc1_);
         var _loc2_:ArenaLogList = new ArenaLogList(_loc1_,_loc3_.gradient_top.graphics,_loc3_.gradient_bottom.graphics);
         _loc2_.width = _loc3_.list_container.graphics.width;
         _loc2_.height = _loc3_.list_container.graphics.height;
         _loc2_.addEventListener("rendererAdd",handler_listRendererAdded);
         _loc2_.addEventListener("rendererRemove",handler_listRendererRemoved);
         _loc2_.itemRendererType = ArenaLogItemRenderer;
         _loc2_.dataProvider = new ListCollection(mediator.logData);
         _loc3_.list_container.layoutGroup.addChild(_loc2_);
      }
      
      private function handler_listRendererAdded(param1:Event, param2:ArenaLogItemRenderer) : void
      {
         param2.signal_select.add(handler_select);
         param2.signal_info.add(handler_info);
         param2.signal_chat.add(handler_chat);
      }
      
      private function handler_listRendererRemoved(param1:Event, param2:ArenaLogItemRenderer) : void
      {
         param2.signal_select.remove(handler_select);
         param2.signal_info.remove(handler_info);
         param2.signal_chat.remove(handler_chat);
      }
      
      private function handler_select(param1:ArenaLogEntryVOProxy) : void
      {
         mediator.action_replay(param1);
      }
      
      private function handler_info(param1:ArenaLogEntryVOProxy) : void
      {
         mediator.action_showInfo(param1);
      }
      
      private function handler_chat(param1:ArenaLogEntryVOProxy) : void
      {
         mediator.action_sendReplay(param1);
      }
   }
}
