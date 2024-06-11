import 'package:jqassistant_dart_lce/src/core/package.dart';

/**
 *  Post-processes the set of all extracted concepts on a cross-package or per-package basis.
 *  Can be used to modify or add language concepts based on existing ones.
 */
abstract base class PostProcessor {
  /**
   * Modifies or adds language concepts of the provided packages in-place.
   *
   * [packages]: list of all processed packages
   */
  void postProcess(List<LCEPackage> packages);
}
