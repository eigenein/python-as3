package game.view.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.HorizontalLayout;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.hero.HeroPopupMediator;
   import game.mediator.gui.popup.hero.skill.HeroPopupSkillValueObject;
   import game.util.TimeFormatter;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import starling.events.Event;
   
   public class HeroPopupSkillList extends GuiClipNestedContainer
   {
       
      
      private var _mediator:HeroPopupMediator;
      
      public var skill_item_4:HeroPopupSkillListItemRenderer;
      
      public var skill_item_3:HeroPopupSkillListItemRenderer;
      
      public var skill_item_2:HeroPopupSkillListItemRenderer;
      
      public var skill_item_1:HeroPopupSkillListItemRenderer;
      
      public var pointCountLabel:ClipLabel;
      
      public var pointCountZeroLabel:ClipLabel;
      
      public var pointTimerLabel:ClipLabel;
      
      public var pointsNameLabel:ClipLabel;
      
      public var button_fragments_plus:ClipButton;
      
      public var header_layout:ClipLayout;
      
      public var header_layout_vertical:ClipLayout;
      
      public function HeroPopupSkillList()
      {
         pointCountLabel = new ClipLabel(true);
         pointCountZeroLabel = new ClipLabel(true);
         pointTimerLabel = new ClipLabel(true);
         pointsNameLabel = new ClipLabel(true);
         button_fragments_plus = new ClipButton();
         header_layout = ClipLayout.horizontalMiddleLeft(4,pointsNameLabel,pointCountLabel,pointCountZeroLabel,pointTimerLabel,button_fragments_plus);
         header_layout_vertical = ClipLayout.verticalMiddleCenter(-3);
         super();
      }
      
      public function set mediator(param1:HeroPopupMediator) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _mediator = param1;
         _mediator.signal_skillPointsUpdate.add(updateSkillPointCount);
         _mediator.signal_skillPointTimerUpdate.add(updateSkillPointTimer);
         var _loc3_:int = _mediator.skillList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this["skill_item_" + (_loc4_ + 1)];
            _loc2_.signal_skillUpgrade.add(onUpgradeSignal);
            _loc4_++;
         }
         updateSkillPointCount();
      }
      
      public function updateSkills() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = _mediator.skillList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this["skill_item_" + (_loc3_ + 1)];
            _loc1_.data = _mediator.skillList[_loc3_];
            _loc3_++;
         }
      }
      
      public function getSkillRenderer(param1:SkillDescription) : HeroPopupSkillListItemRenderer
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = _mediator.skillList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_mediator.skillList[_loc4_].skill.skill == param1)
            {
               _loc2_ = this["skill_item_" + (_loc4_ + 1)];
               return _loc2_;
            }
            _loc4_++;
         }
         return null;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         pointsNameLabel.text = Translate.translate("UI_DIALOG_HERO_SKILL_POINTS");
         pointsNameLabel.validate();
         if(pointsNameLabel.width > 142)
         {
            header_layout_vertical.addChild(pointsNameLabel);
            header_layout_vertical.addChild(header_layout);
            (header_layout.layout as HorizontalLayout).horizontalAlign = "center";
         }
         button_fragments_plus.signal_click.add(onRefillClick);
      }
      
      private function updateSkillPointTimer() : void
      {
         updateSkillPointCount();
      }
      
      private function updateSkillPointCount() : void
      {
         var _loc1_:* = _mediator.skillPointsAvailable == 0;
         pointCountLabel.visible = !_loc1_;
         pointCountZeroLabel.visible = _loc1_;
         if(_loc1_)
         {
            pointCountZeroLabel.text = _mediator.skillPointsAvailable + "/" + _mediator.skillPointsMax;
         }
         else
         {
            pointCountLabel.text = _mediator.skillPointsAvailable + "/" + _mediator.skillPointsMax;
         }
         if(_mediator.skillPointsRegenTimer > 0)
         {
            pointTimerLabel.text = "(" + TimeFormatter.toMS2(_mediator.skillPointsRegenTimer,"{m}:{s}") + ")";
         }
         else
         {
            pointTimerLabel.text = "";
         }
      }
      
      private function onListRendererAdded(param1:Event, param2:HeroPopupSkillListItemRenderer) : void
      {
         param2.signal_skillUpgrade.add(onUpgradeSignal);
      }
      
      private function onListRendererRemoved(param1:Event, param2:HeroPopupSkillListItemRenderer) : void
      {
         param2.signal_skillUpgrade.remove(onUpgradeSignal);
      }
      
      private function onRefillClick() : void
      {
         _mediator.action_skillPointsRefill();
      }
      
      private function onUpgradeSignal(param1:HeroPopupSkillValueObject) : void
      {
         _mediator.action_skillUpgrade(param1);
      }
   }
}
