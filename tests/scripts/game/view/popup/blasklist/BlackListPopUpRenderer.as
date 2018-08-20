package game.view.popup.blasklist
{
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.model.user.chat.ChatUserData;
   import game.view.gui.components.controller.TouchClickController;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.gui.components.list.ListItemRenderer;
   import idv.cjcat.signals.Signal;
   import starling.filters.ColorMatrixFilter;
   
   public class BlackListPopUpRenderer extends ListItemRenderer
   {
       
      
      private var userData:ChatUserData;
      
      private var clip:BlackListPopUpRendererClip;
      
      private var nickLG:LayoutGroup;
      
      private var hoverFilter:ColorMatrixFilter;
      
      private var nickClickController:TouchClickController;
      
      private var nickHoverController:TouchHoverContoller;
      
      private var _signal_nickClick:Signal;
      
      private var _signal_buttonClick:Signal;
      
      public function BlackListPopUpRenderer()
      {
         _signal_nickClick = new Signal(ChatUserData);
         _signal_buttonClick = new Signal(ChatUserData);
         super();
         hoverFilter = new ColorMatrixFilter();
         hoverFilter.adjustBrightness(-0.3);
      }
      
      override public function set data(param1:Object) : void
      {
         if(data != param1)
         {
            .super.data = param1;
            userData = param1 as ChatUserData;
            invalidate("data");
         }
      }
      
      public function get signal_nickClick() : Signal
      {
         return _signal_nickClick;
      }
      
      public function get signal_buttonClick() : Signal
      {
         return _signal_buttonClick;
      }
      
      override public function dispose() : void
      {
         nickClickController.dispose();
         nickHoverController.dispose();
         hoverFilter.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(BlackListPopUpRendererClip,"black_list_renderer");
         addChild(clip.graphics);
         clip.action_button.signal_click.add(handler_acton);
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.paddingTop = 5;
         _loc1_.paddingBottom = 5;
         nickLG = new LayoutGroup();
         nickLG.layout = _loc1_;
         nickLG.x = clip.tf_nick.x;
         nickLG.y = clip.tf_nick.y - _loc1_.paddingTop;
         addChild(nickLG);
         nickLG.addChild(clip.tf_nick);
         nickClickController = new TouchClickController(clip.tf_nick);
         nickClickController.onClick.add(handler_nickClick);
         nickHoverController = new TouchHoverContoller(clip.tf_nick);
         nickHoverController.signal_hoverChanger.add(handler_nickHover);
      }
      
      override protected function draw() : void
      {
         if(isInvalid("data") && clip && userData)
         {
            clip.tf_nick.text = userData.nickname;
         }
         super.draw();
      }
      
      private function handler_nickHover() : void
      {
         if(nickHoverController.hover)
         {
            nickLG.filter = hoverFilter;
         }
         else
         {
            nickLG.filter = null;
         }
      }
      
      private function handler_nickClick() : void
      {
         signal_nickClick.dispatch(userData);
      }
      
      private function handler_acton() : void
      {
         _signal_buttonClick.dispatch(userData);
      }
   }
}
