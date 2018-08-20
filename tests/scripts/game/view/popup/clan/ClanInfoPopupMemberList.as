package game.view.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.VerticalLayout;
   import game.mediator.gui.popup.clan.ClanMemberListPrivateValueObject;
   import game.view.gui.components.ClipButtonLabeledUnderlined;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.GuiClipLayoutContainer;
   import idv.cjcat.signals.Signal;
   import starling.events.Event;
   
   public class ClanInfoPopupMemberList extends GuiClipNestedContainer
   {
       
      
      public var button_switch_activity_type:ClipButtonLabeledUnderlined;
      
      public var button_switch_activity_period:ClipButtonLabeledUnderlined;
      
      public var tf_label_name:ClipLabel;
      
      public var tf_label_points:ClipLabel;
      
      public var tf_label_position:ClipLabel;
      
      public var layout_header_activity:ClipLayout;
      
      public var list:GameScrolledList;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      private var _signal_edit:Signal;
      
      private var _signal_dismiss:Signal;
      
      private var _signal_profile:Signal;
      
      public function ClanInfoPopupMemberList()
      {
         button_switch_activity_type = new ClipButtonLabeledUnderlined();
         button_switch_activity_period = new ClipButtonLabeledUnderlined();
         tf_label_name = new ClipLabel();
         tf_label_points = new ClipLabel(true);
         tf_label_position = new ClipLabel();
         layout_header_activity = ClipLayout.horizontalRight(3,button_switch_activity_type,tf_label_points,button_switch_activity_period);
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         _signal_edit = new Signal(ClanMemberListPrivateValueObject);
         _signal_dismiss = new Signal(ClanMemberListPrivateValueObject);
         _signal_profile = new Signal(ClanMemberListPrivateValueObject);
         super();
      }
      
      public function get signal_edit() : Signal
      {
         return _signal_edit;
      }
      
      public function get signal_dismiss() : Signal
      {
         return _signal_dismiss;
      }
      
      public function get signal_profile() : Signal
      {
         return _signal_profile;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_label_name.text = Translate.translate("UI_DIALOG_CLAN_INFO_PERSON_NAME");
         tf_label_points.text = Translate.translate("UI_DIALOG_CLAN_INFO_PERSON_ACTIVITY_FOR");
         tf_label_position.text = Translate.translate("UI_DIALOG_CLAN_INFO_PERSON_POSITION");
         var _loc2_:GameScrollBar = new GameScrollBar();
         _loc2_.height = scroll_slider_container.graphics.height;
         scroll_slider_container.container.addChild(_loc2_);
         list = new GameScrolledList(_loc2_,gradient_top.graphics,gradient_bottom.graphics);
         list.width = list_container.container.width;
         list.height = list_container.container.height;
         list_container.container.addChild(list);
         list.itemRendererType = ClanMemberListItemRenderer;
         var _loc3_:VerticalLayout = new VerticalLayout();
         var _loc4_:* = 5;
         _loc3_.paddingTop = _loc4_;
         _loc3_.paddingBottom = _loc4_;
         _loc3_.gap = 5;
         list.layout = _loc3_;
         _loc4_ = false;
         gradient_top.graphics.touchable = _loc4_;
         gradient_bottom.graphics.touchable = _loc4_;
         list.addEventListener("rendererAdd",onListRendererAdded);
         list.addEventListener("rendererRemove",onListRendererRemoved);
      }
      
      private function onListRendererAdded(param1:Event, param2:ClanMemberListItemRenderer) : void
      {
         param2.signal_dismiss.add(handler_onDismissSignal);
         param2.signal_editRole.add(handler_onEditRoleSignal);
         param2.signal_profile.add(handler_profile);
      }
      
      private function onListRendererRemoved(param1:Event, param2:ClanMemberListItemRenderer) : void
      {
         param2.signal_dismiss.remove(handler_onDismissSignal);
         param2.signal_editRole.remove(handler_onEditRoleSignal);
         param2.signal_profile.remove(handler_profile);
      }
      
      private function handler_onDismissSignal(param1:ClanMemberListPrivateValueObject) : void
      {
         _signal_dismiss.dispatch(param1);
      }
      
      private function handler_onEditRoleSignal(param1:ClanMemberListPrivateValueObject) : void
      {
         _signal_edit.dispatch(param1);
      }
      
      private function handler_profile(param1:ClanMemberListPrivateValueObject) : void
      {
         _signal_profile.dispatch(param1);
      }
   }
}
