package game.view.popup.selectaccount
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.player.server.ServerListUserValueObject;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.ClipBasedPopup;
   import starling.events.Event;
   
   public class SelectAccountPopUp extends ClipBasedPopup
   {
       
      
      private var mediator:SelectAccountPopUpMediator;
      
      private var clip:SelectAccountPopUpClip;
      
      private var list:GameScrolledList;
      
      public function SelectAccountPopUp(param1:SelectAccountPopUpMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(SelectAccountPopUpClip,"popup_select_account");
         addChild(clip.graphics);
         clip.tf_title.text = Translate.translate("UI_DIALOG_MERGE_TITLE");
         clip.tf_desc.text = Translate.translate("UI_DIALOG_MERGE_DESC2");
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         list = new GameScrolledList(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         list.isSelectable = true;
         list.width = clip.list_container.graphics.width;
         list.height = clip.list_container.graphics.height;
         list.itemRendererType = SelectAccountItemRenderer;
         list.dataProvider = new ListCollection(mediator.accounts);
         list.selectedIndex = 0;
         list.addEventListener("rendererAdd",onListRendererAdded);
         list.addEventListener("rendererRemove",onListRendererRemoved);
         var _loc2_:VerticalLayout = new VerticalLayout();
         _loc2_.paddingTop = 0;
         _loc2_.paddingBottom = 0;
         _loc2_.gap = 10;
         list.layout = _loc2_;
         clip.list_container.container.addChild(list);
      }
      
      private function onListRendererAdded(param1:Event, param2:SelectAccountItemRenderer) : void
      {
         param2.signal_select.add(handler_select);
      }
      
      private function onListRendererRemoved(param1:Event, param2:SelectAccountItemRenderer) : void
      {
         param2.signal_select.remove(handler_select);
      }
      
      private function handler_select(param1:ServerListUserValueObject) : void
      {
         mediator.selectAccount(param1);
      }
   }
}
