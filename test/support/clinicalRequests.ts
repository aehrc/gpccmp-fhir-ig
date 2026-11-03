import type { FhirResource } from 'fhir/r4';

function requestKey(query: string): string {
  const separator = query.indexOf('?');
  if (separator < 0) return query;
  const entries = [...new URLSearchParams(query.slice(separator + 1))].sort(
    ([ak, av], [bk, bv]) =>
      ak < bk ? -1 : ak > bk ? 1 : av < bv ? -1 : av > bv ? 1 : 0
  );
  return `${query.slice(0, separator)}?${new URLSearchParams(entries)}`;
}

/** Clinical requests only. Terminology remains on the renderer/populate live paths. */
export function createClinicalAdapter(
  entries: readonly (readonly [string, FhirResource])[]
) {
  const responses = new Map<string, FhirResource>();
  for (const [query, resource] of entries) {
    const key = requestKey(query);
    if (responses.has(key))
      throw new Error(`Duplicate clinical fixture: ${query}`);
    responses.set(key, structuredClone(resource));
  }
  const requests: {
    query: string;
    sourceServerUrl: string;
    matched: boolean;
  }[] = [];
  const callback = async (
    query: string,
    config: { sourceServerUrl: string }
  ): Promise<FhirResource> => {
    const resource = responses.get(requestKey(query));
    requests.push({
      query,
      sourceServerUrl: config.sourceServerUrl,
      matched: resource !== undefined
    });
    if (!resource)
      throw new Error(
        `Unexpected clinical request (${config.sourceServerUrl}): ${query}`
      );
    return structuredClone(resource);
  };
  return { callback, requests };
}
