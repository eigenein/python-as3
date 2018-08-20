package game.view.gui.overlay
{
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.text.BitmapFontTextFormat;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.GameLabel;
   import game.view.gui.overlay.offer.SocialQuestIconClip;
   import starling.filters.BlurFilter;
   
   public class PlayerPortraitGroupGuiClip extends GuiClipNestedContainer
   {
       
      
      public var button_dailyQuest:RedDotLabeledClipButton;
      
      public var button_mail:RedDotLabeledClipButton;
      
      public var button_dailyBonus:RedDotLabeledClipButton;
      
      public var button_change_portrait:ClipButton;
      
      public var button_nicknameChange:PlayerPortraitNicknameButton;
      
      public var button_vip:PlayerPortraitVIPButton;
      
      public var container_portrait:GuiClipContainer;
      
      public var social_quest_icon:SocialQuestIconClip;
      
      public function PlayerPortraitGroupGuiClip()
      {
         container_portrait = new GuiClipContainer();
         super();
         button_vip = new PlayerPortraitVIPButton();
         button_nicknameChange = new PlayerPortraitNicknameButton();
      }
      
      private function createNicknameLabel() : GameLabel
      {
         var _loc1_:GameLabel = new GameLabel();
         _loc1_.textRendererProperties.textFormat = new BitmapFontTextFormat(AssetStorage.font.Officina14,18,16777215,"center");
         _loc1_.filter = BlurFilter.createDropShadow(2,3.14159265358979 / 2,0,0.5,0,1);
         return _loc1_;
      }
      
      private function createPlayerLevelLabel() : GameLabel
      {
         var _loc1_:GameLabel = new GameLabel();
         _loc1_.textRendererProperties.textFormat = new BitmapFontTextFormat(AssetStorage.font.Officina20,18,16777215,"center");
         _loc1_.filter = BlurFilter.createDropShadow(2,3.14159265358979 / 2,0,0.5,0,1);
         return _loc1_;
      }
      
      private function createVIPLabel() : GameLabel
      {
         var _loc1_:GameLabel = new GameLabel();
         _loc1_.textRendererProperties.textFormat = new BitmapFontTextFormat(AssetStorage.font.Officina14,18,16777215,"center");
         _loc1_.filter = BlurFilter.createDropShadow(2,3.14159265358979 / 2,0,0.5,0,1);
         return _loc1_;
      }
   }
}
