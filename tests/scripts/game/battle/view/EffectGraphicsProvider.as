package game.battle.view
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.starling.ClipAssetDataProvider;
   import com.progrestar.framework.ares.starling.ClipSkin;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import game.battle.view.hero.HeroClipAssetDataProvider;
   
   public class EffectGraphicsProvider
   {
      
      public static const scale:Number = 1;
      
      public static const MISSING:EffectGraphicsProvider = new EffectGraphicsProvider(null,null);
      
      public static const IDENTITY_TRANSFORM:Matrix = new Matrix(1,0,0,1);
      
      public static const MIRROR_TRANSFORM:Matrix = new Matrix(-1,0,0,1);
      
      public static const IDENT_BACK:String = "_BACK";
      
      public static const IDENT_CONTAINER:String = "_CONTAINER";
      
      public static const IDENT_STATUS:String = "_STATUS";
      
      public static const IDENT_HIT:String = "_HIT";
      
      public static const IDENT_DISPLACEMENT:String = "_DISPLACEMENT";
      
      public static const IDENT_LOOP:String = "_LOOP";
      
      public static const IDENT_END:String = "_END";
       
      
      private var asset:HeroClipAssetDataProvider;
      
      private var name:String;
      
      public var back:Clip;
      
      public var front:Clip;
      
      public var container:Clip;
      
      public var backLoop:Clip;
      
      public var frontLoop:Clip;
      
      public var containerLoop:Clip;
      
      public var status:Clip;
      
      public var statusLoop:Clip;
      
      public var displacement:Clip;
      
      public var displacementLoop:Clip;
      
      public var hit:Clip;
      
      public function EffectGraphicsProvider(param1:HeroClipAssetDataProvider, param2:String)
      {
         super();
         this.asset = param1;
         this.name = param2;
         if(param1 != null && param2 != null)
         {
            back = param1.getClipByName(param2 + "_BACK");
            backLoop = param1.getClipByName(param2 + "_BACK" + "_LOOP");
            front = param1.getClipByName(param2);
            frontLoop = param1.getClipByName(param2 + "_LOOP");
            container = param1.getClipByName(param2 + "_CONTAINER");
            containerLoop = param1.getClipByName(param2 + "_CONTAINER" + "_LOOP");
            status = param1.getClipByName(param2 + "_STATUS");
            statusLoop = param1.getClipByName(param2 + "_STATUS" + "_LOOP");
            displacement = param1.getClipByName(param2 + "_DISPLACEMENT");
            displacementLoop = param1.getClipByName(param2 + "_DISPLACEMENT" + "_LOOP");
            hit = param1.getClipByName(param2 + "_HIT");
         }
      }
      
      public static function getFxName(param1:String) : String
      {
         return param1.replace("_BACK","").replace("_CONTAINER","").replace("_HIT","");
      }
      
      public static function hasFx(param1:HeroClipAssetDataProvider, param2:String) : Boolean
      {
         if(param1.getClipByName(param2))
         {
            return true;
         }
         if(param1.getClipByName(param2 + "_BACK"))
         {
            return true;
         }
         if(param1.getClipByName(param2 + "_CONTAINER"))
         {
            return true;
         }
         if(param1.getClipByName(param2 + "_STATUS"))
         {
            return true;
         }
         if(param1.getClipByName(param2 + "_DISPLACEMENT"))
         {
            return true;
         }
         return false;
      }
      
      public function get bounds() : Rectangle
      {
         if(front)
         {
            return front.bounds;
         }
         if(back)
         {
            return back.bounds;
         }
         return null;
      }
      
      public function get clipAssetDataProvider() : ClipAssetDataProvider
      {
         return asset.frameProvider;
      }
      
      public function get clipAsset() : ClipAsset
      {
         return asset.soundAsset;
      }
      
      public function get defaultScale() : Number
      {
         return asset.defaultScale;
      }
      
      public function get transform() : Matrix
      {
         var _loc1_:Number = NaN;
         if(asset && asset.defaultScale != 1)
         {
            _loc1_ = asset.defaultScale;
            return new Matrix(!!asset.mirrored?-_loc1_:Number(_loc1_),0,0,_loc1_);
         }
         return !!asset?!!asset.mirrored?MIRROR_TRANSFORM:IDENTITY_TRANSFORM:IDENTITY_TRANSFORM;
      }
      
      public function createFrontSkin() : ClipSkin
      {
         return asset.createSkin(front);
      }
      
      public function createBackSkin() : ClipSkin
      {
         return asset.createSkin(back);
      }
   }
}
