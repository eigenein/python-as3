package game.mechanics.clan_war.popup.war
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.mechanics.clan_war.popup.ClanWarBuildingButton;
   
   public class ClanWarMapClip extends GuiClipNestedContainer
   {
       
      
      public var building:Vector.<ClanWarBuildingButton>;
      
      public var ground_anim:GuiClipNestedContainer;
      
      public var sky_anim:GuiAnimation;
      
      public var statue_1:ClipSprite;
      
      public var color1:Vector.<GuiClipImage>;
      
      public var color2:Vector.<GuiClipImage>;
      
      public var color3:Vector.<GuiClipImage>;
      
      public var torch_anim_1:GuiAnimation;
      
      public var torch_anim_2:GuiAnimation;
      
      public var icegate_top:GuiAnimation;
      
      public function ClanWarMapClip()
      {
         building = new Vector.<ClanWarBuildingButton>();
         ground_anim = new GuiClipNestedContainer();
         sky_anim = new GuiAnimation();
         statue_1 = new ClipSprite();
         color1 = new Vector.<GuiClipImage>();
         color2 = new Vector.<GuiClipImage>();
         color3 = new Vector.<GuiClipImage>();
         torch_anim_1 = new GuiAnimation();
         torch_anim_2 = new GuiAnimation();
         icegate_top = new GuiAnimation();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         sky_anim.playbackSpeed = 0.15;
         statue_1.graphics.touchable = false;
      }
      
      public function setClanIcon(param1:ClanIconValueObject) : void
      {
         if(param1.flagColor1 == param1.flagColor2)
         {
            colorImages(color1,param1.flagColor1);
            colorImages(color2,param1.iconColor);
            colorImages(color3,param1.flagColor2);
         }
         else
         {
            colorImages(color1,param1.flagColor1);
            colorImages(color2,param1.flagColor2);
            colorImages(color3,param1.flagColor1);
         }
      }
      
      protected function colorImages(param1:Vector.<GuiClipImage>, param2:uint) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:uint = AssetStorage.rsx.clan_icons.getColor(param2);
         var _loc6_:int = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc3_ = param1[_loc5_];
            if(_loc3_)
            {
               _loc3_.image.color = _loc4_;
            }
            _loc5_++;
         }
      }
   }
}
