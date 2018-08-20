package game.mechanics.grand.popup.log
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.mechanics.grand.mediator.log.GrandLogListPopupMediator;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.arena.log.ArenaLogPopupClip;
   
   public class GrandLogListPopup extends ClipBasedPopup
   {
       
      
      private var mediator:GrandLogListPopupMediator;
      
      public function GrandLogListPopup(param1:GrandLogListPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc4_:ArenaLogPopupClip = AssetStorage.rsx.popup_theme.create_dialog_arena_log();
         addChild(_loc4_.graphics);
         _loc4_.title = Translate.translate("UI_DIALOG_LOG_GRAND_NAME");
         _loc4_.tf_message.visible = mediator.logData.length == 0;
         _loc4_.button_close.signal_click.add(mediator.close);
         width = _loc4_.dialog_frame.graphics.width;
         height = _loc4_.dialog_frame.graphics.height;
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = _loc4_.scroll_slider_container.container.height;
         _loc4_.scroll_slider_container.container.addChild(_loc1_);
         var _loc3_:GameScrolledList = new GameScrolledList(_loc1_,_loc4_.gradient_top.graphics,_loc4_.gradient_bottom.graphics);
         _loc3_.itemRendererType = GrandLogListItemRenderer;
         _loc3_.width = _loc4_.list_container.graphics.width;
         _loc3_.height = _loc4_.list_container.graphics.height;
         var _loc2_:VerticalLayout = new VerticalLayout();
         var _loc5_:int = 20;
         _loc2_.paddingBottom = _loc5_;
         _loc2_.paddingTop = _loc5_;
         _loc2_.gap = 5;
         _loc3_.layout = _loc2_;
         _loc3_.dataProvider = mediator.logData;
         _loc4_.list_container.layoutGroup.addChild(_loc3_);
      }
   }
}
