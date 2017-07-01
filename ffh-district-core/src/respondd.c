#include <respondd.h>

#include <json-c/json.h>
#include <libgluonutil.h>

#include <uci.h>

#include <string.h>


static struct json_object * get_district(void) {
	struct uci_context *ctx = uci_alloc_context();
	ctx->flags &= ~UCI_FLAG_STRICT;

	struct uci_package *p;
	if (uci_load(ctx, "gluon-node-info", &p))
		goto error;

	struct uci_section *s = uci_lookup_section(ctx, p, "district");
	if (!s)
		goto error;

	struct json_object *ret = gluonutil_wrap_string(uci_lookup_option_string(ctx, s, "current"));

	uci_free_context(ctx);

	return ret;

 error:
	uci_free_context(ctx);

	return NULL;
}

static struct json_object * respondd_provider_nodeinfo(void) {
	struct json_object *ret = json_object_new_object();

	json_object_object_add(ret, "district", get_district());

	return ret;
}


const struct respondd_provider_info respondd_providers[] = {
	{"nodeinfo", respondd_provider_nodeinfo},
	{}
};
