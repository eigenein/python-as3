package game.assets.storage.rsx
{
   import engine.core.clipgui.ClipSprite;
   import flash.display.BitmapData;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.view.popup.clan.editicon.ClanIconClip;
   import starling.textures.Texture;
   
   public class RsxClanIconsAsset extends RsxGuiAsset
   {
      
      public static const IDENT:String = "clan_icons";
       
      
      private var palleteBitmap:BitmapData;
      
      public function RsxClanIconsAsset(param1:*)
      {
         super(param1);
      }
      
      override public function complete() : void
      {
         super.complete();
         palleteBitmap = AssetStorage.rsx.clan_icons.getBitmapData("palette");
      }
      
      public function createIconClip() : ClanIconClip
      {
         var _loc1_:ClanIconClip = new ClanIconClip();
         initGuiClip(_loc1_,"icon_compose");
         return _loc1_;
      }
      
      public function createFlagClip() : ClanIconClip
      {
         var _loc1_:ClanIconClip = new ClanIconClip();
         initGuiClip(_loc1_,"flag_compose");
         return _loc1_;
      }
      
      public function createEmptyClip() : ClipSprite
      {
         var _loc1_:ClipSprite = new ClipSprite();
         initGuiClip(_loc1_,"flag_empty");
         return _loc1_;
      }
      
      public function setupFlag(param1:ClanIconClip, param2:ClanIconValueObject) : void
      {
         param1.setupCanvas(getFlagColorPatternTexture(param2.flagShape),getColor(param2.flagColor1),getColor(param2.flagColor2));
         param1.setupIcon(getIconTexture(param2.iconShape),getColor(param2.iconColor));
      }
      
      public function setupIcon(param1:ClanIconClip, param2:ClanIconValueObject) : void
      {
         param1.setupCanvas(getIconColorPatternTexture(param2.flagShape),getColor(param2.flagColor1),getColor(param2.flagColor2));
         param1.setupIcon(getIconTexture(param2.iconShape),getColor(param2.iconColor));
      }
      
      public function getColor(param1:int) : uint
      {
         return palleteBitmap.getPixel(param1,0);
      }
      
      public function getIconTexture(param1:int) : Texture
      {
         return AssetStorage.rsx.clan_icons.getTexture("symbol" + (param1 + 1));
      }
      
      public function getFlagColorPatternTexture(param1:int) : Texture
      {
         return AssetStorage.rsx.clan_icons.getTexture("pattern" + (param1 + 1));
      }
      
      public function getIconColorPatternTexture(param1:int) : Texture
      {
         return AssetStorage.rsx.clan_icons.getTexture("square_pattern" + (param1 + 1));
      }
      
      public function get numColors() : int
      {
         return palleteBitmap.width;
      }
      
      public function get numIcons() : int
      {
         return 50;
      }
      
      public function get numColorPatterns() : int
      {
         return 17;
      }
   }
}
