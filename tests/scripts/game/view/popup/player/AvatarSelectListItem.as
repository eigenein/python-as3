package game.view.popup.player
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.player.AvatarSelectValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class AvatarSelectListItem extends ListItemRenderer implements ITooltipSource
   {
       
      
      private var clip:AvatarPickRendererClip;
      
      private var _tooltipVO:TooltipVO;
      
      private var _signal_select:Signal;
      
      public function AvatarSelectListItem()
      {
         super();
         _signal_select = new Signal(AvatarSelectValueObject);
         _tooltipVO = new TooltipVO(TooltipTextView,null);
         addEventListener("addedToStage",handler_addedToStage);
         addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      override protected function commitData() : void
      {
         var _loc1_:AvatarSelectValueObject = data as AvatarSelectValueObject;
         if(_loc1_)
         {
            _tooltipVO.hintData = _loc1_.taskDescription;
            clip.lock.graphics.visible = !_loc1_.available;
            clip.check.graphics.visible = _loc1_.selected;
            clip.check_anim.graphics.visible = _loc1_.justUnlocked;
            clip.red_marker.graphics.visible = _loc1_.justUnlocked;
            if(_loc1_.justUnlocked)
            {
               clip.check_anim.playOnce();
            }
            clip.portrait.setAvatarDescriptionOnly(_loc1_.desc);
         }
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:AvatarSelectValueObject = data as AvatarSelectValueObject;
         if(_loc2_)
         {
            _loc2_.signal_availableStateChange.remove(handler_update);
         }
         .super.data = param1;
         _loc2_ = data as AvatarSelectValueObject;
         if(_loc2_)
         {
            _loc2_.signal_availableStateChange.add(handler_update);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_renderer_avatar_select();
         addChild(clip.graphics);
         clip.portrait.graphics.touchable = true;
         height = 96;
         width = 96;
         clip.check_anim.graphics.touchable = false;
         clip.signal_click.add(handler_selectClick);
      }
      
      private function handler_selectClick() : void
      {
         var _loc1_:AvatarSelectValueObject = data as AvatarSelectValueObject;
         if(_loc1_)
         {
            _signal_select.dispatch(_loc1_);
         }
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         dispatchEventWith("TooltipEventType.SOURCE_ADDED",true);
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         dispatchEventWith("TooltipEventType.SOURCE_REMOVED",true);
      }
      
      private function handler_update(param1:AvatarSelectValueObject) : void
      {
         commitData();
      }
   }
}
