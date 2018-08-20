package game.view.popup.ny.gifts
{
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.controller.IButtonView;
   import game.view.gui.components.controller.TouchButtonController;
   import game.view.gui.components.list.ListItemRenderer;
   import starling.filters.ColorMatrixFilter;
   import starling.filters.FragmentFilter;
   
   public class NYGiftsPopupTabRenderer extends ListItemRenderer implements IButtonView
   {
       
      
      private var mediator:NYGiftsPopupTabRendererMediator;
      
      private var clip:NYGiftsPopupTabRendererClip;
      
      private var touchController:TouchButtonController;
      
      private var containerFilter:FragmentFilter;
      
      public function NYGiftsPopupTabRenderer()
      {
         super();
         useHandCursor = true;
         mediator = new NYGiftsPopupTabRendererMediator();
         mediator.signalUpdate.add(onTabUpdate);
      }
      
      override public function dispose() : void
      {
         mediator.signalUpdate.remove(onTabUpdate);
         mediator.dispose();
         touchController.dispose();
         super.dispose();
      }
      
      override public function set data(param1:Object) : void
      {
         .super.data = param1;
         if(mediator.tabElement == data)
         {
            return;
         }
         mediator.tabElement = data as NYGiftsPopupTabRendererVO;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid("selected"))
         {
            if(clip)
            {
               _loc1_ = this.isSelected;
               clip.bg_selected.graphics.visible = _loc1_;
               var _loc2_:* = !_loc1_;
               clip.tf_text.includeInLayout = _loc2_;
               clip.tf_text.visible = _loc2_;
               _loc2_ = _loc1_;
               clip.tf_text_selected.includeInLayout = _loc2_;
               clip.tf_text_selected.visible = _loc2_;
            }
         }
      }
      
      public function click() : void
      {
         isSelected = true;
      }
      
      public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(param1 == "hover")
         {
            _loc3_ = new ColorMatrixFilter();
            _loc3_.adjustBrightness(0.1);
            containerFilter = clip.container.filter;
            clip.container.filter = _loc3_;
         }
         else
         {
            if(clip.container.filter)
            {
               clip.container.filter.dispose();
            }
            clip.container.filter = containerFilter;
            containerFilter = null;
         }
      }
      
      override protected function initialize() : void
      {
         clip = AssetStorage.rsx.popup_theme.create_ny_gifts_popup_tab_renderer();
         addChild(clip.graphics);
         touchController = new TouchButtonController(clip.container,this);
      }
      
      override protected function commitData() : void
      {
         if(mediator.tabElement)
         {
            onTabUpdate();
            clip.tf_text.text = mediator.tabName;
            clip.tf_text_selected.text = mediator.tabName;
         }
      }
      
      private function onTabUpdate() : void
      {
         clip.animation_highlight.graphics.visible = mediator.giftsToOpenAvaliable;
      }
   }
}
