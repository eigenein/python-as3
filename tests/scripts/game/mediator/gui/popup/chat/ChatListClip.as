package game.mediator.gui.popup.chat
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.VerticalLayout;
   import game.model.user.chat.ChatMessageReplayData;
   import game.model.user.chat.ChatUserData;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.GuiClipLayoutContainer;
   import idv.cjcat.signals.Signal;
   import starling.events.Event;
   
   public class ChatListClip extends GuiClipNestedContainer
   {
       
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      private var _list:GameScrolledList;
      
      private var _signal_select:Signal;
      
      private var _signal_challenge:Signal;
      
      private var _signal_replay:Signal;
      
      private var _signal_headerClick:Signal;
      
      private var _signal_replay_share:Signal;
      
      public function ChatListClip()
      {
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         _signal_select = new Signal(ChatUserData);
         _signal_challenge = new Signal(ChatPopupLogValueObject);
         _signal_replay = new Signal(ChatPopupLogValueObject);
         _signal_headerClick = new Signal(ChatPopupLogValueObject);
         _signal_replay_share = new Signal(ChatMessageReplayData);
         super();
      }
      
      public function get list() : GameScrolledList
      {
         return _list;
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get signal_challenge() : Signal
      {
         return _signal_challenge;
      }
      
      public function get signal_replay() : Signal
      {
         return _signal_replay;
      }
      
      public function get signal_headerClick() : Signal
      {
         return _signal_headerClick;
      }
      
      public function get signal_replay_share() : Signal
      {
         return _signal_replay_share;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc4_:Boolean = false;
         gradient_top.graphics.touchable = _loc4_;
         gradient_bottom.graphics.touchable = _loc4_;
         var _loc2_:GameScrollBar = new GameScrollBar();
         _loc2_.height = scroll_slider_container.graphics.height;
         scroll_slider_container.container.addChild(_loc2_);
         _list = new GameScrolledList(_loc2_,gradient_top.graphics,gradient_bottom.graphics);
         var _loc3_:VerticalLayout = new VerticalLayout();
         _loc3_.verticalAlign = "bottom";
         _loc3_.useVirtualLayout = false;
         _loc3_.padding = 10;
         _loc3_.gap = 5;
         _loc3_.hasVariableItemDimensions = true;
         _list.layout = _loc3_;
         list.width = list_container.graphics.width;
         list.height = list_container.graphics.height;
         list_container.container.addChild(list);
         list.itemRendererType = ChatListItemRenderer;
         list.addEventListener("rendererAdd",onListRendererAdded);
         list.addEventListener("rendererRemove",onListRendererRemoved);
      }
      
      private function onListRendererAdded(param1:Event, param2:ChatListItemRenderer) : void
      {
         param2.signal_select.add(handler_select);
         param2.signal_challenge.add(handler_challenge);
         param2.signal_replay.add(handler_replay);
         param2.signal_headerClick.add(handler_headerClick);
         param2.signal_replay_share.add(handler_replay_share);
      }
      
      private function onListRendererRemoved(param1:Event, param2:ChatListItemRenderer) : void
      {
         param2.signal_select.remove(handler_select);
         param2.signal_challenge.remove(handler_challenge);
         param2.signal_replay.remove(handler_replay);
         param2.signal_headerClick.remove(handler_headerClick);
         param2.signal_replay_share.remove(handler_replay_share);
      }
      
      private function handler_replay_share(param1:ChatMessageReplayData) : void
      {
         _signal_replay_share.dispatch(param1);
      }
      
      private function handler_select(param1:ChatUserData) : void
      {
         _signal_select.dispatch(param1);
      }
      
      private function handler_challenge(param1:ChatPopupLogValueObject) : void
      {
         _signal_challenge.dispatch(param1);
      }
      
      private function handler_replay(param1:ChatPopupLogValueObject) : void
      {
         _signal_replay.dispatch(param1);
      }
      
      private function handler_headerClick(param1:ChatPopupLogValueObject) : void
      {
         _signal_headerClick.dispatch(param1);
      }
   }
}
