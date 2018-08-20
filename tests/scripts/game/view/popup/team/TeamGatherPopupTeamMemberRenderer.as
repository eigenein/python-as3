package game.view.popup.team
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.GameButton;
   import game.view.gui.components.HeroPortraitWithTweenableShade;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.events.Event;
   
   public class TeamGatherPopupTeamMemberRenderer extends ListItemRenderer implements ITooltipSource
   {
       
      
      protected var portrait:HeroPortraitWithTweenableShade;
      
      protected var button:GameButton;
      
      protected var emptySlot:Image;
      
      private var _tooltipVO:TooltipVO;
      
      public function TeamGatherPopupTeamMemberRenderer()
      {
         super();
         _tooltipVO = new TooltipVO(TooltipTextView,null);
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         portrait.dispose();
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      public function animateSelection(param1:Number) : void
      {
         var _loc2_:TeamGatherPopupHeroValueObject = data as TeamGatherPopupHeroValueObject;
         if(_loc2_ != null && !_loc2_.isEmpty)
         {
            portrait.shadingDisabledProgress = 0;
            Starling.juggler.tween(portrait,param1,{
               "shadingDisabledProgress":1,
               "transition":"easeIn",
               "onComplete":portrait.popOut
            });
         }
      }
      
      override protected function commitData() : void
      {
         var _loc1_:TeamGatherPopupHeroValueObject = data as TeamGatherPopupHeroValueObject;
         if(_loc1_)
         {
            portrait.data = _loc1_.unitEntryVo;
            _tooltipVO.hintData = createHintData(_loc1_);
         }
         updateState(_loc1_);
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:TeamGatherPopupHeroValueObject = data as TeamGatherPopupHeroValueObject;
         if(_loc2_)
         {
            _loc2_.signal_update.remove(onDataUpdate);
         }
         .super.data = param1;
         _loc2_ = data as TeamGatherPopupHeroValueObject;
         if(_loc2_)
         {
            _loc2_.signal_update.add(onDataUpdate);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         emptySlot = new Image(AssetStorage.rsx.popup_theme.getTexture("emptySlot"));
         addChild(emptySlot);
         portrait = new HeroPortraitWithTweenableShade();
         addChild(portrait);
         button = new GameButton();
         var _loc1_:int = 96;
         button.width = _loc1_;
         button.height = _loc1_;
         button.signal_click.add(buttonClick);
         addChild(button);
      }
      
      protected function updateState(param1:TeamGatherPopupHeroValueObject) : void
      {
         var _loc2_:Boolean = param1 == null || param1.isEmpty;
         portrait.visible = !_loc2_;
         emptySlot.visible = _loc2_;
      }
      
      private function buttonClick() : void
      {
         if(data)
         {
            (data as TeamGatherPopupHeroValueObject).select();
         }
      }
      
      protected function createHintData(param1:TeamGatherPopupHeroValueObject) : String
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(!param1.isEmpty)
         {
            _loc3_ = param1.roleString;
            _loc2_ = param1.desc.name;
            if(_loc3_)
            {
               _loc2_ = _loc2_ + ("\n" + param1.roleString);
            }
            if(!param1.isAvailable)
            {
               return _loc2_ + "\n" + param1.blockReason.text;
            }
            return _loc2_;
         }
         return null;
      }
      
      private function onDataUpdate(param1:TeamGatherPopupHeroValueObject) : void
      {
         invalidate("data");
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         TooltipLayerMediator.instance.addSource(this);
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         TooltipLayerMediator.instance.removeSource(this);
      }
   }
}
