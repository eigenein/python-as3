package game.view.gui.components
{
   import feathers.controls.Label;
   import feathers.layout.AnchorLayoutData;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.titan.TitanEntryValueObject;
   import game.view.popup.hero.HeroStarDisplay;
   import starling.display.Image;
   
   public class HeroPortrait extends HeroPortraitBase
   {
       
      
      protected var starDisplay:HeroStarDisplay;
      
      protected var levelLabelBg:Image;
      
      protected var levelLabel:Label;
      
      public function HeroPortrait()
      {
         super();
      }
      
      override public function set disabled(param1:Boolean) : void
      {
         .super.disabled = param1;
         if(starDisplay)
         {
            starDisplay.disabled = param1;
            levelLabelBg.color = !!param1?7829367:16777215;
            levelLabel.alpha = !!param1?0.5:1;
         }
      }
      
      public function update_level() : void
      {
         if(levelLabel && data)
         {
            levelLabel.text = data.level.toString();
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         starDisplay = new HeroStarDisplay();
         starDisplay.touchable = false;
         addChild(starDisplay);
         starDisplay.width = 80;
         starDisplay.layoutData = new AnchorLayoutData();
         (starDisplay.layoutData as AnchorLayoutData).horizontalCenter = 0;
         (starDisplay.layoutData as AnchorLayoutData).bottom = 3;
         levelLabelBg = new Image(AssetStorage.rsx.popup_theme.getTexture("level_white"));
         levelLabelBg.touchable = false;
         levelLabelBg.y = 1;
         levelLabelBg.x = 28;
         addChild(levelLabelBg);
         levelLabel = GameLabel.label();
         levelLabel.touchable = false;
         levelLabel.layoutData = new AnchorLayoutData();
         (levelLabel.layoutData as AnchorLayoutData).horizontalCenterAnchorDisplayObject = levelLabelBg;
         (levelLabel.layoutData as AnchorLayoutData).horizontalCenter = 1;
         (levelLabel.layoutData as AnchorLayoutData).verticalCenterAnchorDisplayObject = levelLabelBg;
         (levelLabel.layoutData as AnchorLayoutData).verticalCenter = -2;
         addChild(levelLabel);
      }
      
      override protected function commitData() : void
      {
         if(!data || data.empty)
         {
            return;
         }
         levelLabelBg.texture = data.levelBackgroundAssetTexture;
         icon.texture = data.icon;
         frame.texture = data.qualityFrame;
         background.texture = data.qualityBackground;
         starDisplay.setValue(data.starCount);
         var _loc1_:* = data.level;
         levelLabelBg.visible = _loc1_;
         levelLabel.visible = _loc1_;
         levelLabel.text = data.level.toString();
         if(data is TitanEntryValueObject)
         {
            _loc1_ = 8;
            icon.x = _loc1_;
            background.x = _loc1_;
            _loc1_ = 8;
            icon.y = _loc1_;
            background.y = _loc1_;
            frame.width = 97;
            frame.height = 99;
            icon.height = 84;
            icon.height = 84;
         }
         else
         {
            _loc1_ = 8;
            icon.x = _loc1_;
            background.x = _loc1_;
            _loc1_ = 8;
            icon.y = _loc1_;
            background.y = _loc1_;
            frame.width = 96;
            frame.height = 96;
            icon.width = 80;
            icon.height = 80;
         }
      }
      
      public function updateStars() : void
      {
         starDisplay.setValue(data.starCount);
      }
      
      public function updateColor() : void
      {
         starDisplay.setValue(data.starCount);
         levelLabelBg.texture = data.levelBackgroundAssetTexture;
         frame.texture = data.qualityFrame;
         background.texture = data.qualityBackground;
      }
   }
}
